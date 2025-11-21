sed -i 's|<device> /var/log    <fstype>     defaults|<device> /var/log    <fstype>     defaults,rw,nosuid,nodev,noexec,relatime|' /etc/fstab && mount -o remount /var/log
