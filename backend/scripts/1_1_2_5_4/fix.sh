# Edit /etc/fstab to add noexec option for /var/tmp
# Example entry:
# <device> /var/tmp    <fstype>     defaults,rw,nosuid,nodev,noexec,relatime  0 0
# Remount the partition
mount -o remount /var/tmp
