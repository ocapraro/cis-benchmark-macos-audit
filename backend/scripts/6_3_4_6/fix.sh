#!/bin/bash
# Set proper ownership on audit configuration files
if [ -d /etc/audit ]; then
    find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root -exec chown root {} + 2>/dev/null
fi
