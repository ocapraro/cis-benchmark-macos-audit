#!/bin/bash
# macOS Auditd Config Repair Script (Extended)
# Ensures /etc/security/audit_control exists and configures flags properly

AUDIT_DIR="/var/audit"
AUDIT_CONF="/etc/security/audit_control"

echo "[*] Checking audit configuration..."

# 1. Ensure /etc/security exists
if [ ! -d "/etc/security" ]; then
    echo "[+] Creating /etc/security directory..."
    sudo mkdir -p /etc/security
fi

# 2. Create /etc/security/audit_control if missing
if [ ! -f "$AUDIT_CONF" ]; then
    echo "[+] Creating missing audit_control configuration..."
    sudo tee "$AUDIT_CONF" >/dev/null <<'EOF'
# Where audit logs go
dir:/var/audit

# What to audit for logged-in users
flags:lo

# What to audit for non-attributed events (before login)
naflags:lo

# Keep auditing even if something fails; include argv for execs
policy:cnt,argv

# Rotate when free space is low; per-file size cap (approx)
minfree:5
filesz:2M
EOF
else
    echo "[=] audit_control already exists — will verify and modify flags."
fi

# 3. Ensure /var/audit directory exists with proper permissions
if [ ! -d "$AUDIT_DIR" ]; then
    echo "[+] Creating $AUDIT_DIR..."
    sudo mkdir -p "$AUDIT_DIR"
fi
sudo chown root:wheel "$AUDIT_DIR"
sudo chmod 700 "$AUDIT_DIR"

# 4. Edit flags: replace or merge with target set
echo "[*] Updating flags in $AUDIT_CONF ..."

# Extract current flags line if any
CURRENT_FLAGS=$(grep -E '^flags:' "$AUDIT_CONF" 2>/dev/null | head -n1)

# Define desired flags — use "-all" to cover fm, ex, fr, fw
TARGET_FLAGS="flags:ad,aa,lo,-all"

if [ -z "$CURRENT_FLAGS" ]; then
    echo "[+] Adding missing flags line..."
    echo "$TARGET_FLAGS" | sudo tee -a "$AUDIT_CONF" >/dev/null
else
    echo "[+] Replacing existing flags with: $TARGET_FLAGS"
    sudo sed -i.bak -E "s/^flags:.*/$TARGET_FLAGS/" "$AUDIT_CONF"
fi

# 5. Reload audit configuration and restart auditd
echo "[*] Reloading audit configuration..."
sudo /usr/sbin/audit -s

echo "[*] Ensuring auditd is enabled and running..."
sudo launchctl enable system/com.apple.auditd
sudo launchctl bootstrap system /System/Library/LaunchDaemons/com.apple.auditd.plist 2>/dev/null || true
sudo launchctl kickstart -k system/com.apple.auditd

echo "[✔] Audit subsystem checked and configured successfully."
echo "[i] Flags now set to: ad, aa, lo, -all"
