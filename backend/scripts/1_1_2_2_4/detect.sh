findmnt -kn /dev/shm | grep -v 'noexec' || exit 0; exit 1
