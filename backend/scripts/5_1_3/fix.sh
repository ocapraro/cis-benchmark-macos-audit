#!/bin/bash
# Set proper permissions on SSH public keys
for keyfile in /etc/ssh/ssh_host_*_key.pub; do
    if [ -f "$keyfile" ]; then
        chmod 0644 "$keyfile"
        chown root:root "$keyfile"
    fi
done
