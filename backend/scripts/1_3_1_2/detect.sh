grubby --info=ALL | grep -Po '(selinux|enforcing)=0\b' || exit 1
