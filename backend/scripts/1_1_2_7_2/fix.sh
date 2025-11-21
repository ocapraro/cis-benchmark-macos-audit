# Edit /etc/fstab to add nodev to the fourth field for /var/log/audit
# Example entry:
# <device> /var/log/audit <fstype> defaults,rw,nosuid,nodev,noexec,relatime 0 0
# Remount the partition
mount -o remount /var/log/audit; exit 0
