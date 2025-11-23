#!/bin/bash
# Disable Xwayland by configuring GDM
if [ -f /etc/gdm/custom.conf ]; then
    if ! grep -q '^WaylandEnable=false' /etc/gdm/custom.conf; then
        sed -i '/^\[daemon\]/a WaylandEnable=false' /etc/gdm/custom.conf
    fi
    systemctl restart gdm 2>/dev/null || true
else
    echo "GDM not installed - /etc/gdm/custom.conf not found"
fi
