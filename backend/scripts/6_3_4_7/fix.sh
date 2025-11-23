#!/bin/bash
# Set proper group ownership on audit configuration files
if [ -d /etc/audit ]; then
    find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root -exec chgrp root {} + 2>/dev/null
fi
