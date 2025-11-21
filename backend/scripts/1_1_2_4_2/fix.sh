sed -i 's|<device> /var    <fstype>     defaults,rw,nosuid|<device> /var    <fstype>     defaults,rw,nosuid,nodev|' /etc/fstab && mount -o remount /var
