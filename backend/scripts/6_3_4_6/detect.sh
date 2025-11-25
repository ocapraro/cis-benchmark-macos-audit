#!/bin/bash
if [ -d /etc/audit ]; then
    result=$(find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root 2>/dev/null)
    if [ -z "$result" ]; then
        echo "Nothing should be returned"
    else
        echo "$result"
    fi
else
    echo "Nothing should be returned"
fi
