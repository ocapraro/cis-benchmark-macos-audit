#!/bin/bash
# Create or update macOS login window policy banner and set correct perms.
# Works with /Library/Security/PolicyBanner.txt and/or PolicyBanner.rtf

set -euo pipefail

SEC_DIR="/Library/Security"
TXT="$SEC_DIR/PolicyBanner.txt"
RTF="$SEC_DIR/PolicyBanner.rtf"

# Accept banner text via argument or environment (BANNER_TEXT). If neither, use a default.
BANNER_TEXT="${1:-${BANNER_TEXT:-}}"
DEFAULT_TEXT="Authorized use only. By proceeding you acknowledge monitoring and consent to policy."

ensure_dir() {
  if [ ! -d "$SEC_DIR" ]; then
    echo "[+] Creating $SEC_DIR"
    sudo mkdir -p "$SEC_DIR"
  fi
}

write_txt_if_missing() {
  if [ -n "$BANNER_TEXT" ]; then
    echo "[*] Writing banner text to $TXT"
    printf '%s\n' "$BANNER_TEXT" | sudo tee "$TXT" >/dev/null
  elif [ ! -f "$TXT" ] && [ ! -f "$RTF" ]; then
    echo "[*] No text provided and no banner exists; creating default $TXT"
    printf '%s\n' "$DEFAULT_TEXT" | sudo tee "$TXT" >/dev/null
  else
    echo "[=] Skipping text write (banner already exists or RTF present)."
  fi
}

fix_perms() {
  for f in "$TXT" "$RTF"; do
    if [ -f "$f" ]; then
      echo "[*] Fixing ownership and permissions on $f"
      sudo chown root:wheel "$f"
      # World-readable so loginwindow can display it
      sudo chmod o+r "$f"
      # Typical mode: 0644
      sudo chmod 0644 "$f"
    fi
  done
}

main() {
  ensure_dir
  write_txt_if_missing
  fix_perms
  echo "[✔] Login window banner configured."
  echo "    - Edit text later with: sudo nano $TXT  (or supply text via arg/ENV and rerun)"
}

main "$@"
