stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/crontab | grep 'Access: (600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)' && exit 0 || exit 1
