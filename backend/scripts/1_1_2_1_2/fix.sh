#!/bin/bash
# Add nodev option to /tmp mount point

# Apply nodev option immediately
mount -o remount,nodev /tmp

# Update systemd tmp.mount unit if it exists
if systemctl is-active --quiet tmp.mount; then
    systemctl daemon-reload
    systemctl restart tmp.mount
fi
