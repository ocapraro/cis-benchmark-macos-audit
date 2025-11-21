findmnt -kn /dev/shm | grep -v 'nosuid' || exit 0; exit 1
