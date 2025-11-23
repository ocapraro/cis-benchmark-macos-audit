#!/bin/bash
# Enable reverse path filtering
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1
# Make it persistent
if ! grep -q '^net.ipv4.conf.all.rp_filter' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv4.conf.all.rp_filter = 1' >> /etc/sysctl.d/99-sysctl.conf
fi
if ! grep -q '^net.ipv4.conf.default.rp_filter' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv4.conf.default.rp_filter = 1' >> /etc/sysctl.d/99-sysctl.conf
fi
