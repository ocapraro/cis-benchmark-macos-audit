#!/bin/bash
# Configure GDM to disable user list
if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.login-screen disable-user-list true
else
    echo "gsettings not available - GDM may not be installed"
fi
