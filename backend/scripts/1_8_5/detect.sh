#!/bin/bash
if command -v gsettings &>/dev/null; then
    gsettings get org.gnome.desktop.media-handling autorun-never 2>/dev/null || echo "false"
else
    echo "false"
fi
