findmnt -kn /dev/shm | grep -E '^/dev/shm\s+tmpfs\s+tmpfs\s+rw,nosuid,nodev,noexec,relatime,seclabel$'
