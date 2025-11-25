#!/bin/bash
for keyfile in /etc/ssh/ssh_host_*_key; do
    if [ -f "$keyfile" ]; then
        stat -L "$keyfile" 2>/dev/null | grep -E 'Access.*0(600|640).*Uid.*root.*Gid.*(root|ssh_keys)' && echo "$(basename $keyfile): root:root/ssh_keys 0600/0640"
    fi
done | head -1 || echo ""
