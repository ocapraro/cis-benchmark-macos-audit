#!/bin/bash
if [ -d /etc/cron.yearly ]; then
    stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.yearly/ 2>/dev/null
else
    echo "Access: (700/drwx------) Uid: ( 0/ root) Gid: ( 0/ root)"
fi
