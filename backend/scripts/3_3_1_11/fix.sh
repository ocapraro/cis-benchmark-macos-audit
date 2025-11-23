#!/bin/bash
# Disable accepting IPv4 default secure redirects
sysctl -w net.ipv4.conf.default.secure_redirects=0
# Make it persistent
if ! grep -q '^net.ipv4.conf.default.secure_redirects' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv4.conf.default.secure_redirects = 0' >> /etc/sysctl.d/99-sysctl.conf
fi
