#!/bin/bash
if [ -f /etc/gdm/custom.conf ]; then
    sed -n '/\[daemon\]/,/\[/p' /etc/gdm/custom.conf 2>/dev/null | grep -i 'WaylandEnable' || echo ""
else
    echo ""
fi
