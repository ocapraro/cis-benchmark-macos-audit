#!/bin/bash
# Safely comment out or remove "Defaults !log_allowed" in /etc/sudoers

set -euo pipefail

SUDOERS_FILE="/etc/sudoers"
STAMP=$(date +%Y%m%d%H%M%S)
TMP=$(mktemp)

echo "[*] Checking for $SUDOERS_FILE..."

if [ ! -f "$SUDOERS_FILE" ]; then
  echo "[✖] $SUDOERS_FILE not found! Exiting."
  exit 1
fi

BACKUP="${SUDOERS_FILE}.bak.${STAMP}"
echo "[*] Creating backup at $BACKUP"
sudo cp -p "$SUDOERS_FILE" "$BACKUP"

echo "[*] Commenting out or removing 'Defaults !log_allowed'..."
sudo awk '
{
  # Match any line beginning with "Defaults" and containing "!log_allowed"
  if ($0 ~ /^[[:space:]]*Defaults[[:space:]]*!log_allowed/) {
    print "#" $0 "   # Commented out by compliance script"
  } else {
    print $0
  }
}' "$SUDOERS_FILE" | sudo tee "$TMP" >/dev/null

echo "[*] Validating syntax with visudo..."
if sudo /usr/sbin/visudo -cf "$TMP"; then
  echo "[✔] Syntax OK. Applying changes..."
  sudo cp "$TMP" "$SUDOERS_FILE"
  sudo chmod 440 "$SUDOERS_FILE"
  sudo chown root:wheel "$SUDOERS_FILE"
  echo "[✔] 'Defaults !log_allowed' has been commented out successfully."
else
  echo "[✖] visudo validation failed. Original sudoers preserved at $BACKUP."
  exit 1
fi

rm -f "$TMP"
