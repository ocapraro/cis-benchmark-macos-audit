#!/bin/bash
# Set proper group ownership on audit configuration files
if [ -d /etc/audit ]; then
    find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root -exec chgrp root {} + 2>/dev/null || true
    echo "Audit configuration files group ownership updated"
else
    echo "Audit directory not found - audit may not be installed"
fi
exit 0
