#!/bin/bash
# Set proper permissions on SSH private keys
for keyfile in /etc/ssh/ssh_host_*_key; do
    if [ -f "$keyfile" ]; then
        chown root:ssh_keys "$keyfile" 2>/dev/null && chmod 0640 "$keyfile" || {
            chown root:root "$keyfile"
            chmod 0600 "$keyfile"
        }
    fi
done
