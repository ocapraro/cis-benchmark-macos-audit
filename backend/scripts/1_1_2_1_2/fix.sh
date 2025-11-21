#!/bin/bash
# Add nodev option to /tmp mount point

# Check if /tmp entry exists in /etc/fstab
if grep -q "^[^#]*[[:space:]]/tmp[[:space:]]" /etc/fstab; then
    # /tmp is in fstab, add nodev if not present
    sed -i.bak '/^[^#]*[[:space:]]\/tmp[[:space:]]/ {
        /nodev/! s/\([[:space:]][[:alnum:],]*\)/\1,nodev/
    }' /etc/fstab
else
    # /tmp not in fstab, using tmpfs
    echo "tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime 0 0" >> /etc/fstab
fi

# Remount /tmp with new options
mount -o remount,nodev /tmp || systemctl daemon-reload && systemctl restart tmp.mount
