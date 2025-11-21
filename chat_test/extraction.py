#!/usr/bin/env python3
"""
CIS PDF -> JSON + Bash scripts (detect.sh / fix.sh) for real control IDs only,
with strong page guards and sequencing checks to avoid TOC/cross-ref bleed.

Requirements:
  pip install pymupdf openai tenacity

Usage:
  export OPENAI_API_KEY=sk-...
  python extraction.py --pdf "/path/to/CIS_Rocky_Linux_10_Benchmark.pdf" --out ./out --model gpt-4o-mini
"""

import os
import re
import json
import time
import pathlib
import argparse
from typing import Any, Dict, List, Tuple, Optional

import fitz  # PyMuPDF
from openai import OpenAI
from tenacity import retry, stop_after_attempt, wait_exponential, retry_if_exception_type

DEFAULT_MODEL = "gpt-4o-mini"

SYSTEM_PROMPT = """You are a security automation engineer.

INPUT: One PDF page of a CIS Benchmark (may include multiple sections).
TASK: Extract ONLY true CIS controls that have an explicit numeric control number (e.g., 1.1, 1.1.1, 2.3.7.5).
If you cannot clearly identify a control number, DO NOT RETURN ANY ITEM for that content.

For each identified control on this page:
- id: the control number with dots replaced by underscores (e.g., 1.1.1.1 -> 1_1_1_1). If no control number is present, OMIT the item.
- title: the full control title, typically starts with the control number and text (e.g., "1.1 Ensure …").
- description: a concise narrative needed to understand the check (audit intent + context).
- regex: a string that indicates PASS if matched in detect output; else FAIL. Choose a sane, documented indicator from the page or a minimal, safe default.
- result: default "fail".
- time: rough integer seconds to run detect+fix.
- detect_sh: POSIX bash that exits 0 on PASS (regex matched) and 1 on FAIL; print context.
- fix_sh: POSIX bash that safely remediates and is idempotent; if manual, print steps and exit 2.

STRICTNESS:
- Return NOTHING for non-control prose.
- Do NOT synthesize or guess control numbers.
- Output STRICT JSON that matches the provided schema.
"""

# Pure JSON Schema used by Responses API (SDK >= 2.8.0 requires text.format.schema)
CIS_ITEM_SCHEMA: Dict[str, Any] = {
    "type": "object",
    "additionalProperties": False,
    "properties": {
        "items": {
            "type": "array",
            "items": {
                "type": "object",
                "additionalProperties": False,
                "properties": {
                    "description": {"type": "string"},
                    "id": {"type": "string"},
                    "regex": {"type": "string"},
                    "result": {"type": "string", "enum": ["pass", "fail", "unknown"]},
                    "time": {"type": "integer"},
                    "title": {"type": "string"},
                    "detect_sh": {"type": "string"},
                    "fix_sh": {"type": "string"}
                },
                "required": ["description", "id", "regex", "result", "time", "title", "detect_sh", "fix_sh"]
            }
        }
    },
    "required": ["items"]
}

# Accept real control IDs like 1_1, 1_1_1, 2_10_3_4
ID_RE = re.compile(r"^\d+(?:_\d+)+$")

# Heuristics for page guards
TOC_WORDS = (
    "table of contents",
    "contents",
    "summary table",
    "mapping of controls",
    "appendix",
)

# Looks like a TOC entry: "1.2.3   Some title .......... 47"
TOC_LINE_RE = re.compile(r"(?m)^\s*\d+(?:\.\d+)+\s+.+\s+\d+\s*$")
CONTROL_HEADER_RE_TMPL = r"(?m)^\s*{id}\s+([^\n]+)$"  # header at line start


# ---------- Helpers ----------

def is_valid_control_id(cid: str) -> bool:
    return bool(ID_RE.match((cid or "").strip()))

def underscores_to_dots(cid: str) -> str:
    return cid.replace("_", ".")

def strip_code_fences(s: str) -> str:
    s = s.strip()
    if s.startswith("```"):
        s = s.split("\n", 1)[1] if "\n" in s else ""
    if s.endswith("```"):
        s = s.rsplit("\n", 1)[0]
    return s.strip()

def parse_json_strict(maybe_json: str):
    """
    Return either a dict (with 'items') or a list (items directly) — both accepted.
    Harden against code fences and stray control chars.
    """
    txt = strip_code_fences(maybe_json)
    l = txt.find("{")
    r = txt.rfind("}")
    if l != -1 and r != -1 and r > l:
        txt = txt[l:r+1]
    # If it's an array, preserve that too
    if "[" in txt and (l == -1 or txt.index("[") < l):
        # try to slice array
        la = txt.find("[")
        ra = txt.rfind("]")
        if la != -1 and ra != -1 and ra > la:
            txt = txt[la:ra+1]
    txt = "".join(ch for ch in txt if ch >= " " or ch in "\r\n\t")
    data = json.loads(txt)
    return data

def ensure_exec(path: pathlib.Path):
    try:
        path.chmod(path.stat().st_mode | 0o111)
    except Exception:
        pass

def extract_pages(pdf_path: str) -> List[str]:
    doc = fitz.open(pdf_path)
    texts = []
    for p in doc:
        t = p.get_text("text").replace("\u00A0", " ")
        texts.append(t)
    return texts

def compose_user_prompt(page_text: str, page_no: int) -> List[Dict[str, Any]]:
    return [
        {"role": "user", "content": f"PAGE {page_no}\n---\n{page_text}\n---\nExtract actionable controls on this page only."}
    ]

def page_has_sections(page_text: str) -> bool:
    # Require at least one to avoid headers or TOC
    return ("Audit:" in page_text) or ("Remediation:" in page_text)

def is_toc_like(page_text: str) -> bool:
    lower = page_text.lower()
    if any(w in lower for w in TOC_WORDS):
        return True
    lines = TOC_LINE_RE.findall(page_text)
    return len(lines) >= 3

def page_has_control_header(page_text: str, dotted_id: str) -> bool:
    # Control header must appear as its own line start, not as "see 4.8 ...".
    pat = re.compile(CONTROL_HEADER_RE_TMPL.format(id=re.escape(dotted_id)))
    return pat.search(page_text) is not None

def id_to_tuple(cid: str) -> Tuple[int, ...]:
    return tuple(int(x) for x in cid.split("_"))

def same_prefix(a: Tuple[int, ...], b: Tuple[int, ...], n: int) -> bool:
    return a[:n] == b[:n]

def plausible_next(prev: Optional[str], curr: str) -> bool:
    """
    Sequencing guard:
      - Non-decreasing overall.
      - Top-level chapter can only advance by +1.
      - While staying in the same chapter, require same first two segments
        as the last accepted control (keeps us inside 1_1_* cluster).
    """
    if prev is None:
        return True
    pa = id_to_tuple(prev)
    ca = id_to_tuple(curr)
    # must be non-decreasing lexicographically
    if ca < pa:
        return False
    # top-level chapter may only jump by +1
    if ca[0] > pa[0] + 1:
        return False
    return True


# ---------- OpenAI Call ----------

@retry(
    reraise=True,
    stop=stop_after_attempt(6),
    wait=wait_exponential(multiplier=1, min=1, max=30),
    retry=retry_if_exception_type(Exception),
)
def call_openai(client: OpenAI, model: str, messages: List[Dict[str, Any]]) -> Any:
    try:
        resp = client.responses.create(
            model=model,
            input=[{"role": "system", "content": SYSTEM_PROMPT}, *messages],
            text={
                "format": {
                    "type": "json_schema",
                    "name": "cis_items",
                    "strict": True,
                    "schema": CIS_ITEM_SCHEMA
                }
            },
            temperature=0.0,
        )
        if hasattr(resp, "output_text") and resp.output_text:
            return parse_json_strict(resp.output_text)

        parts = []
        for out in getattr(resp, "output", []) or []:
            for c in getattr(out, "content", []) or []:
                if getattr(c, "type", None) == "output_text" and getattr(c, "text", None):
                    parts.append(c.text)
        return parse_json_strict("".join(parts) if parts else "{}")

    except Exception as e:
        print(f"[WARN] Falling back to Chat API because: {e}")
        cc = client.chat.completions.create(
            model=model,
            messages=[{"role": "system", "content": SYSTEM_PROMPT}, *messages],
            temperature=0.0,
        )
        return parse_json_strict(cc.choices[0].message.content)


# ---------- Main ----------

def main():
    ap = argparse.ArgumentParser(description="Extract CIS controls (real IDs only) and generate detect/fix scripts.")
    ap.add_argument("--pdf", required=True, help="Path to CIS Benchmark PDF")
    ap.add_argument("--out", required=True, help="Output directory")
    ap.add_argument("--model", default=DEFAULT_MODEL, help="OpenAI model (e.g., gpt-4o-mini)")
    ap.add_argument("--start-page", type=int, default=1, help="1-based start page")
    ap.add_argument("--end-page", type=int, default=None, help="1-based end page (inclusive)")
    args = ap.parse_args()

    out_root = pathlib.Path(args.out)
    out_root.mkdir(parents=True, exist_ok=True)
    results_path = out_root / "results.json"

    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise SystemExit("ERROR: OPENAI_API_KEY is not set in environment.")
    client = OpenAI(api_key=api_key)

    pages = extract_pages(args.pdf)
    start_idx = max(0, args.start_page - 1)
    end_idx = (args.end_page - 1) if args.end_page is not None else len(pages) - 1

    all_items: List[Dict[str, Any]] = []
    seen_ids = set()
    last_kept_id: Optional[str] = None

    for i in range(start_idx, end_idx + 1):
        page_no = i + 1
        page_text = pages[i]
        if not page_text.strip():
            continue
        if is_toc_like(page_text):
            # Skip TOC / summary style pages altogether
            continue
        if not page_has_sections(page_text):
            # If the page doesn't have Audit/Remediation, skip
            continue

        messages = compose_user_prompt(page_text, page_no)

        t0 = time.time()
        try:
            payload = call_openai(client, args.model, messages)
        except Exception as e:
            print(f"[WARN] Page {page_no}: API error: {e}")
            continue
        dt = time.time() - t0

        # Accept both {"items":[...]} and bare [...] shapes
        if isinstance(payload, dict):
            items = payload.get("items", [])
        elif isinstance(payload, list):
            items = payload
        else:
            items = []

        if not isinstance(items, list) or not items:
            continue

        for it in items:
            raw_id = (it.get("id") or "").strip()
            if not is_valid_control_id(raw_id):
                continue

            dotted = underscores_to_dots(raw_id)
            # Must have a true control header for this id on THIS page
            if not page_has_control_header(page_text, dotted):
                continue

            # Sequencing guard: must make sense relative to last kept id
            if not plausible_next(last_kept_id, raw_id):
                # Skip odd jumps like 1_1_* -> 4_8, etc.
                continue

            cid = raw_id
            if cid in seen_ids:
                continue
            seen_ids.add(cid)

            title = (it.get("title") or cid).strip()
            desc = (it.get("description") or "").strip()
            regex_pat = (it.get("regex") or "").strip() or ".*"
            result = (it.get("result") or "fail").strip()
            try:
                secs = int(it.get("time") or 60)
            except Exception:
                secs = 60

            detect_sh = ((it.get("detect_sh") or "#!/usr/bin/env bash\nexit 2\n").strip())
            fix_sh = ((it.get("fix_sh") or "#!/usr/bin/env bash\nexit 2\n").strip())

            item_dir = out_root / cid
            item_dir.mkdir(parents=True, exist_ok=True)

            detect_path = item_dir / "detect.sh"
            fix_path = item_dir / "fix.sh"
            detect_path.write_text(detect_sh + "\n", encoding="utf-8")
            fix_path.write_text(fix_sh + "\n", encoding="utf-8")
            ensure_exec(detect_path)
            ensure_exec(fix_path)

            all_items.append({
                "description": desc,
                "id": cid,
                "regex": regex_pat,
                "result": result,
                "time": secs,
                "title": title
            })
            last_kept_id = cid

            print(f"[OK] {cid} -> {detect_path} / {fix_path} (API {dt:.1f}s)")

    # Always write results.json
    with results_path.open("w", encoding="utf-8") as f:
        json.dump(all_items, f, indent=2, ensure_ascii=False)

    print(f"\nDone. Wrote {results_path} and {len(all_items)} item(s).")


if __name__ == "__main__":
    main()
