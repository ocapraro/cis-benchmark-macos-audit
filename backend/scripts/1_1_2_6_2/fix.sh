sed -i 's|<device> /var/log    <fstype>     .*|<device> /var/log    <fstype>     defaults,rw,nosuid,nodev,noexec,relatime  0 0|' /etc/fstab && mount -o remount /var/log
