#!/bin/bash
# Set macOS OpenBSM audit retention: expire-after >= 60d OR 5G

set -euo pipefail

AUDIT_CONF="/etc/security/audit_control"
STAMP="$(date +%Y%m%d%H%M%S)"
TMP="$(mktemp)"

ensure_file() {
  if [ ! -d "/etc/security" ]; then
    echo "[+] Creating /etc/security"
    sudo mkdir -p /etc/security
  fi
  if [ ! -f "$AUDIT_CONF" ]; then
    echo "[+] Creating $AUDIT_CONF"
    sudo tee "$AUDIT_CONF" >/dev/null <<'EOF'
# OpenBSM audit configuration
# See: man audit_control
dir:/var/audit
flags:lo
naflags:lo
policy:cnt,argv
minfree:5
filesz:2M
# Retention (set by policy script)
expire-after:60d
EOF
    sudo chown root:wheel "$AUDIT_CONF"
    sudo chmod 0644 "$AUDIT_CONF"
  fi
}

backup_file() {
  local backup="${AUDIT_CONF}.bak.${STAMP}"
  echo "[*] Backup -> $backup"
  sudo cp -p "$AUDIT_CONF" "$backup"
}

# Normalize/upgrade expire-after to >=60d or >=5G
rewrite_expire_after() {
  sudo awk -v OFS="" '
  BEGIN {
    found = 0
  }
  function tolower_str(s) { gsub(/[A-Z]/, "", s); return tolower(s) }  # not used but kept
  {
    line = $0
    # Match start-of-line (optional spaces) expire-after:
    if (match(line, /^[[:space:]]*expire-after:[[:space:]]*([0-9]+)([[:alpha:]]+)/)) {
      found = 1
      num = substr(line, RSTART+RLENGTH, 0) # unused placeholder
      # Extract captured groups manually since awk doesn’t expose them from match() directly
      # Re-run with a more AWK-friendly approach:
      sub(/^[[:space:]]*expire-after:[[:space:]]*/, "", line)
      # Now line starts with <number><unit>...
      if (match(line, /^([0-9]+)([[:alpha:]]+)/, m)) {
        val = m[1]+0
        unit = m[2]
        # Normalize unit to lowercase for comparisons
        unit_l = unit; gsub(/[A-Z]/, "", unit_l); unit_l = tolower(unit)
        out = ""

        if (unit_l == "d") {
          # Days: ensure >=60
          if (val < 60) { out = "expire-after:60d" } else { out = "expire-after:" val "d" }
        } else if (unit_l == "g") {
          # Gigabytes: ensure >=5
          if (val < 5) { out = "expire-after:5G" } else { out = "expire-after:" val unit } # keep original G/g
        } else {
          # Any other unit (h, w, m, M, etc.) -> force to 60d to meet policy
          out = "expire-after:60d"
        }

        print out
      } else {
        # Couldn’t parse number/unit -> set safe default
        print "expire-after:60d"
      }
    } else {
      print $0
    }
  }
  END {
    if (!found) {
      print "expire-after:60d"
    }
  }' "$AUDIT_CONF" | sudo tee "$TMP" >/dev/null

  sudo mv "$TMP" "$AUDIT_CONF"
  sudo chown root:wheel "$AUDIT_CONF"
  sudo chmod 0644 "$AUDIT_CONF"
}

reload_audit() {
  # Ask audit subsystem to re-read config; harmless if already running
  if command -v /usr/sbin/audit >/dev/null 2>&1; then
    echo "[*] Reloading audit config (audit -s)…"
    sudo /usr/sbin/audit -s || true
  fi
}

main() {
  ensure_file
  backup_file
  rewrite_expire_after
  reload_audit
  echo "[✔] Ensured expire-after is at least 60d or 5G in $AUDIT_CONF"
}

main "$@"
