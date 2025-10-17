#!/bin/bash
# macOS: Enforce `Defaults timestamp_type=tty` in /etc/sudoers.d
# - Creates /etc/sudoers.d if missing
# - Ensures correct owner/group and sane perms
# - Creates/updates 10_cissudoconfiguration (no dot/extension)
# - Replaces any existing timestamp_type setting in that file with tty
# - Avoids duplicates
# - Validates with visudo

set -euo pipefail

SUDOERS_DIR="/etc/sudoers.d"
SUDOERS_FILE="${SUDOERS_DIR}/10_cissudoconfiguration"
REQUIRED_LINE="Defaults timestamp_type=tty"
STAMP="$(date +%Y%m%d%H%M%S)"

echo "[*] Ensuring ${SUDOERS_DIR} exists..."
if [ ! -d "${SUDOERS_DIR}" ]; then
  sudo mkdir -p "${SUDOERS_DIR}"
fi

echo "[*] Ensuring ownership/permissions on ${SUDOERS_DIR}..."
sudo chown -R root:wheel "${SUDOERS_DIR}"
sudo chmod 750 "${SUDOERS_DIR}"

if [ ! -f "${SUDOERS_FILE}" ]; then
  echo "[+] Creating ${SUDOERS_FILE}..."
  echo "${REQUIRED_LINE}" | sudo tee "${SUDOERS_FILE}" >/dev/null
  sudo chown root:wheel "${SUDOERS_FILE}"
  sudo chmod 440 "${SUDOERS_FILE}"
else
  echo "[*] Backing up ${SUDOERS_FILE} -> ${SUDOERS_FILE}.bak.${STAMP}"
  sudo cp -p "${SUDOERS_FILE}" "${SUDOERS_FILE}.bak.${STAMP}"

  echo "[*] Normalizing timestamp_type in ${SUDOERS_FILE}..."
  TMP="$(mktemp)"
  # Replace any existing timestamp_type=... line(s) with exactly `Defaults timestamp_type=tty`,
  # keep comments/other lines, and avoid duplicates.
  sudo awk -v target="${REQUIRED_LINE}" '
    BEGIN { done=0 }
    {
      line=$0
      # If line contains a timestamp_type=... in a Defaults line, normalize it once
      if (match(line, /^[[:space:]]*Defaults([[:space:]].*)?[[:space:]]timestamp_type[[:space:]]*=[[:space:]]*[[:alnum:]_+-]+/)) {
        if (!done) {
          print target
          done=1
        }
        next
      }
      print line
    }
    END {
      if (!done) print target
    }
  ' "${SUDOERS_FILE}" | sudo tee "${TMP}" >/dev/null

  sudo mv "${TMP}" "${SUDOERS_FILE}"
  sudo chown root:wheel "${SUDOERS_FILE}"
  sudo chmod 440 "${SUDOERS_FILE}"
fi

echo "[*] Validating syntax with visudo..."
# Validate the specific drop-in file
sudo /usr/sbin/visudo -cf "${SUDOERS_FILE}"
# Also validate the entire configuration (includes /etc/sudoers.d)
sudo /usr/sbin/visudo -c

echo "[✔] Success: ${REQUIRED_LINE} is set via ${SUDOERS_FILE}"
echo "[i] Reminder: macOS ignores files in /etc/sudoers.d that contain a dot in the filename."
