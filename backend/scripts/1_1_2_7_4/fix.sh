# Edit /etc/fstab to add noexec to the /var/log/audit entry
# Example: <device> /var/log/audit <fstype> defaults,rw,nosuid,nodev,noexec,relatime 0 0
# Then remount the partition
mount -o remount /var/log/audit; exit 0
