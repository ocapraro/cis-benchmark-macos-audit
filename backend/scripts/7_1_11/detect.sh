find / -type f -perm -0002 -print | grep -q . && exit 1 || exit 0
