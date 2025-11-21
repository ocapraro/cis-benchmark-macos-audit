sed -i 's|^tmpfs /dev/shm.*|tmpfs /dev/shm    tmpfs     defaults,rw,nosuid,nodev,noexec,relatime  0 0|' /etc/fstab && mount -o remount /dev/shm
