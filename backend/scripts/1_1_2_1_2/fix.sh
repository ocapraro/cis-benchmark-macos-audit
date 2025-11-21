sed -i 's|<device> /tmp    <fstype>     .*|<device> /tmp    <fstype>     defaults,rw,nosuid,nodev,noexec,relatime  0 0|' /etc/fstab && mount -o remount /tmp
