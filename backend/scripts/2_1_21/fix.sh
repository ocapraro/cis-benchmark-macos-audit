#!/bin/bash
# Configure Postfix for local-only mode
if [ -f /etc/postfix/main.cf ]; then
    sed -i 's/^inet_interfaces.*/inet_interfaces = loopback-only/' /etc/postfix/main.cf
    systemctl restart postfix 2>/dev/null || true
else
    echo "Postfix not installed"
fi
