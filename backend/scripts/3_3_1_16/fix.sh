#!/bin/bash
# Enable logging of martian packets
sysctl -w net.ipv4.conf.all.log_martians=1
sysctl -w net.ipv4.conf.default.log_martians=1
# Make it persistent
if ! grep -q '^net.ipv4.conf.all.log_martians' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv4.conf.all.log_martians = 1' >> /etc/sysctl.d/99-sysctl.conf
fi
if ! grep -q '^net.ipv4.conf.default.log_martians' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'net.ipv4.conf.default.log_martians = 1' >> /etc/sysctl.d/99-sysctl.conf
fi
