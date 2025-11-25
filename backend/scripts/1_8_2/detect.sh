#!/bin/bash
if command -v gsettings &>/dev/null; then
    gsettings get org.gnome.login-screen disable-user-list 2>/dev/null || echo "false"
else
    echo "false"
fi
