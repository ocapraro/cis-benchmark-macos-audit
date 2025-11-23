#!/bin/bash
# Set ProcessSizeMax=0 in coredump.conf
if ! grep -q '^ProcessSizeMax=0' /etc/systemd/coredump.conf; then
    sed -i '/^\[Coredump\]/a ProcessSizeMax=0' /etc/systemd/coredump.conf
fi
systemctl daemon-reload
