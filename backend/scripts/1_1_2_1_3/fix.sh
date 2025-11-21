sed -i 's|<device> /tmp    <fstype>     defaults|<device> /tmp    <fstype>     defaults,rw,nosuid,nodev,noexec,relatime|' /etc/fstab; mount -o remount /tmp; exit 0;
