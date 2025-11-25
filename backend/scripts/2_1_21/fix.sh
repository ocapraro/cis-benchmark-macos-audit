#!/bin/bash
# Configure Postfix for local-only mode
if [ -f /etc/postfix/main.cf ]; then
    # Update or add inet_interfaces setting
    if grep -q '^inet_interfaces' /etc/postfix/main.cf; then
        sed -i 's/^inet_interfaces.*/inet_interfaces = loopback-only/' /etc/postfix/main.cf
    else
        echo 'inet_interfaces = loopback-only' >> /etc/postfix/main.cf
    fi
    
    # Restart postfix if it's running
    if systemctl is-active --quiet postfix 2>/dev/null; then
        systemctl restart postfix 2>/dev/null
    elif service postfix status &>/dev/null; then
        service postfix restart 2>/dev/null
    fi
else
    echo "Postfix configuration file not found"
fi
