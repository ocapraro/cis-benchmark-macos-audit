# Edit /etc/fstab to add 'nosuid' to the fourth field for /dev/shm
# Example: tmpfs /dev/shm    tmpfs     defaults,rw,nosuid,nodev,noexec,relatime  0 0
# Remount /dev/shm with the configured options
mount -o remount /dev/shm
