#!/bin/bash
# Configure GDM to disable user list
if command -v gsettings &> /dev/null; then
    if gsettings list-schemas | grep -q 'org.gnome.login-screen'; then
        gsettings set org.gnome.login-screen disable-user-list true 2>/dev/null
        echo "GDM disable-user-list configured"
    else
        echo "GDM schema not available - GDM may not be installed or configured"
    fi
else
    echo "gsettings not available - GDM may not be installed"
fi
exit 0
