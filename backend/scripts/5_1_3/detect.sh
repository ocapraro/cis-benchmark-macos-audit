#!/bin/bash
for keyfile in /etc/ssh/ssh_host_*_key.pub; do
    if [ -f "$keyfile" ]; then
        stat -L "$keyfile" 2>/dev/null | grep 'mode 0644' && echo "$(basename $keyfile): mode 0644"
    fi
done | head -1 || echo ""
