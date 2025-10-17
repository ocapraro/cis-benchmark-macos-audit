#!/bin/bash
# Fix ASL install log retention on macOS
# - Ensures /etc/asl/com.apple.install exists
# - For every "file ..." rule line:
#     * sets ttl to at least 365 (adds ttl=365 if missing)
#     * removes any all_max=... token
# - Backs up original file
# - Leaves other content intact

set -euo pipefail

ASL_DIR="/etc/asl"
ASL_FILE="$ASL_DIR/com.apple.install"

# 1) Ensure directory exists
if [ ! -d "$ASL_DIR" ]; then
  echo "[+] Creating $ASL_DIR"
  sudo mkdir -p "$ASL_DIR"
fi

# 2) Create file with a sane default if missing
if [ ! -f "$ASL_FILE" ]; then
  echo "[+] Creating $ASL_FILE with a default rule"
  sudo tee "$ASL_FILE" >/dev/null <<'EOF'
# ASL rules for install logs
# Keep at least 365 days
? [= Sender install] file /var/log/install.log ttl=365
EOF
  sudo chown root:wheel "$ASL_FILE"
  sudo chmod 0644 "$ASL_FILE"
fi

# 3) Backup original
STAMP=$(date +%Y%m%d%H%M%S)
BACKUP="${ASL_FILE}.bak.${STAMP}"
echo "[*] Backing up to $BACKUP"
sudo cp -p "$ASL_FILE" "$BACKUP"

# 4) Rewrite any line that contains a 'file' rule:
#    Preserve any leading match conditions, only modify the portion starting at 'file'
TMP=$(mktemp)
sudo awk '
function join(arr, from, to,   i,s){ s=""; for(i=from;i<=to;i++){ s = s ((i>from)?" ":"") arr[i]; } return s }
{
  # Tokenize by whitespace
  n = split($0, t, /[[:space:]]+/)
  fileIdx = 0
  for (i=1; i<=n; i++) {
    if (t[i] == "file" && i < n) { fileIdx = i; break }
  }

  if (fileIdx == 0) {
    print $0
    next
  }

  # Prefix (conditions etc.) before "file"
  prefix = (fileIdx > 1) ? join(t, 1, fileIdx-1) : ""

  # The file path is next token
  filepath = t[fileIdx+1]

  # Rebuild options after path: drop all_max=..., normalize ttl>=365
  haveTTL = 0
  newOpts = ""
  for (i = fileIdx+2; i<=n; i++) {
    opt = t[i]
    if (opt ~ /^all_max=/) {
      # skip
      continue
    } else if (opt ~ /^ttl=/) {
      split(opt, kv, "=")
      ttl = kv[2]+0
      if (ttl < 365) opt = "ttl=365"
      haveTTL = 1
    }
    newOpts = (newOpts == "" ? opt : newOpts " " opt)
  }

  if (!haveTTL) {
    newOpts = (newOpts == "" ? "ttl=365" : newOpts " ttl=365")
  }

  # Reconstruct line
  if (prefix != "")
    print prefix " file " filepath (newOpts=="" ? "" : " " newOpts)
  else
    print "file " filepath (newOpts=="" ? "" : " " newOpts)
}' "$ASL_FILE" | sudo tee "$TMP" >/dev/null

# 5) Replace original
sudo mv "$TMP" "$ASL_FILE"
sudo chown root:wheel "$ASL_FILE"
sudo chmod 0644 "$ASL_FILE"

echo "[✔] Updated $ASL_FILE"
echo "    - Ensured ttl>=365 on file rule(s)"
echo "    - Removed any all_max=... token"
echo "    - Backup saved at: $BACKUP"

# 6) (Optional) Nudge legacy logging daemons (harmless if not present)
if launchctl print system/com.apple.syslogd >/dev/null 2>&1; then
  echo "[*] Restarting syslogd (optional)…"
  sudo launchctl kickstart -k system/com.apple.syslogd || true
fi
if launchctl print system/com.apple.aslmanager >/dev/null 2>&1; then
  echo "[*] Restarting aslmanager (optional)…"
  sudo launchctl kickstart -k system/com.apple.aslmanager || true
fi

echo "[i] Done. Future install logs should retain at least 365 days."
