# Edit /etc/fstab to add nosuid to the /tmp entry
# Example: <device> /tmp <fstype> defaults,rw,nosuid,nodev,noexec,relatime 0 0
# Then remount /tmp
mount -o remount /tmp; exit 0
