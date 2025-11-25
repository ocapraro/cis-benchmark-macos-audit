#!/bin/bash
# Configure GDM to disable autorun
if command -v gsettings &> /dev/null; then
    if gsettings list-schemas | grep -q 'org.gnome.desktop.media-handling'; then
        gsettings set org.gnome.desktop.media-handling autorun-never true 2>/dev/null
        echo "GDM autorun-never configured"
    else
        echo "GDM schema not available - GDM may not be installed or configured"
    fi
else
    echo "gsettings not available - GDM may not be installed"
fi
exit 0
