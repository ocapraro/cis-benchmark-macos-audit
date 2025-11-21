sed -i 's|<device> /var/tmp    <fstype>     defaults|<device> /var/tmp    <fstype>     defaults,rw,nosuid,nodev,noexec,relatime|' /etc/fstab; mount -o remount /var/tmp; exit 0
