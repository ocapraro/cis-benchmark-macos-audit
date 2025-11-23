#!/bin/bash
# Add noexec option to /dev/shm mount point

# Apply noexec option immediately
mount -o remount,noexec /dev/shm

# Update systemd if needed
if systemctl is-active --quiet dev-shm.mount 2>/dev/null; then
    systemctl daemon-reload
    systemctl restart dev-shm.mount
fi

