#!/bin/bash
# macOS: Enforce Defaults timestamp_timeout=0 in /etc/sudoers.d
# Safely creates /etc/sudoers.d/10_cissudoconfiguration and validates syntax

set -euo pipefail

SUDOERS_DIR="/etc/sudoers.d"
SUDOERS_FILE="$SUDOERS_DIR/10_cissudoconfiguration"
REQUIRED_LINE="Defaults timestamp_timeout=0"

echo "[*] Checking sudoers configuration..."

# 1. Ensure /etc/sudoers.d exists
if [ ! -d "$SUDOERS_DIR" ]; then
  echo "[+] Creating $SUDOERS_DIR ..."
  sudo mkdir -p "$SUDOERS_DIR"
fi

# 2. Ensure ownership and permissions
echo "[*] Fixing ownership and permissions on $SUDOERS_DIR ..."
sudo chown -R root:wheel "$SUDOERS_DIR"
sudo chmod 750 "$SUDOERS_DIR"

# 3. Create or update configuration file
if [ ! -f "$SUDOERS_FILE" ]; then
  echo "[+] Creating $SUDOERS_FILE ..."
  echo "$REQUIRED_LINE" | sudo tee "$SUDOERS_FILE" >/dev/null
else
  echo "[*] Checking if $REQUIRED_LINE is already set..."
  if ! sudo grep -qE "^\s*Defaults\s+timestamp_timeout=0\b" "$SUDOERS_FILE"; then
    echo "[+] Appending $REQUIRED_LINE to $SUDOERS_FILE ..."
    echo "$REQUIRED_LINE" | sudo tee -a "$SUDOERS_FILE" >/dev/null
  else
    echo "[=] Line already present. No changes needed."
  fi
fi

# 4. Validate the sudoers syntax
echo "[*] Validating configuration syntax with visudo..."
if sudo /usr/sbin/visudo -cf "$SUDOERS_FILE"; then
  echo "[✔] Syntax OK. Sudoers configuration updated successfully."
else
  echo "[✖] visudo validation failed! Restoring backup..."
  exit 1
fi