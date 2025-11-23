#!/bin/bash
# Disable accepting IPv6 router advertisements
sysctl -w net.ipv6.conf.all.accept_ra=0
sysctl -w net.ipv6.conf.default.accept_ra=0
# Make it persistent
if ! grep -q '^net.ipv6.conf.all.accept_ra' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv6.conf.all.accept_ra = 0' >> /etc/sysctl.d/99-sysctl.conf
fi
if ! grep -q '^net.ipv6.conf.default.accept_ra' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv6.conf.default.accept_ra = 0' >> /etc/sysctl.d/99-sysctl.conf
fi; echo 'net.ipv6.conf.all.accept_ra=0' >> /etc/sysctl.conf; sysctl -p
