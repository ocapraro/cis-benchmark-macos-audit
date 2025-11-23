#!/bin/bash
# Set fs.suid_dumpable to 0
sysctl -w fs.suid_dumpable=0
# Make it persistent
if ! grep -q '^fs.suid_dumpable' /etc/sysctl.conf /etc/sysctl.d/*.conf 2>/dev/null; then
    echo 'fs.suid_dumpable = 0' >> /etc/sysctl.d/99-sysctl.conf
fi
