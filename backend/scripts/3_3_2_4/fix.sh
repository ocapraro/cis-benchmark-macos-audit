#!/bin/bash
# Disable accepting IPv6 default ICMP redirects
sysctl -w net.ipv6.conf.default.accept_redirects=0
# Make it persistent
if ! grep -q '^net.ipv6.conf.default.accept_redirects' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv6.conf.default.accept_redirects = 0' >> /etc/sysctl.d/99-sysctl.conf
fi
