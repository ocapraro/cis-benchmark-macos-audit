stat -Lc 'Access: (%#a/%A)  Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/shells | grep 'Access: (0644/-rw-r--r--)  Uid: ( 0/ root) Gid: ( 0/ root)' && exit 0 || exit 1
