#!/bin/bash
# Configure GDM to disable autorun
if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.media-handling autorun-never true
else
    echo "gsettings not available - GDM may not be installed"
fi
