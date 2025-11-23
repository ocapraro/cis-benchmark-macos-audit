find /home -name '.*' -type f 2>/dev/null | head -10 | xargs stat -c '%a' 2>/dev/null | head -5
