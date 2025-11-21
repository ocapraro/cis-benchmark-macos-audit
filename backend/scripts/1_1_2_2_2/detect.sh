findmnt -kn /dev/shm | grep -v 'nodev' || exit 0; exit 1
