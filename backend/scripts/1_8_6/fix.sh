#!/bin/bash
# Disable Xwayland by configuring GDM
if [ -f /etc/gdm/custom.conf ]; then
    if grep -q '^\[daemon\]' /etc/gdm/custom.conf; then
        if grep -q '^WaylandEnable' /etc/gdm/custom.conf; then
            sed -i 's/^WaylandEnable=.*/WaylandEnable=false/' /etc/gdm/custom.conf
        else
            sed -i '/^\[daemon\]/a WaylandEnable=false' /etc/gdm/custom.conf
        fi
    else
        echo -e "[daemon]\nWaylandEnable=false" >> /etc/gdm/custom.conf
    fi
    systemctl restart gdm 2>/dev/null || echo "GDM restart skipped"
    echo "Xwayland disabled in GDM configuration"
else
    echo "GDM not installed - /etc/gdm/custom.conf not found"
fi
exit 0
