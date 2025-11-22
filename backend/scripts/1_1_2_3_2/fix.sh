#!/bin/bash
# Add nodev option to /home mount point

# Apply nodev option immediately
mount -o remount,nodev /home

# Update systemd home.mount unit if it exists
if systemctl is-active --quiet home.mount; then
    systemctl daemon-reload
    systemctl restart home.mount
fi
