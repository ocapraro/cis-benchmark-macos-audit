sed -i 's|<device> /var/log/audit    <fstype>     |<device> /var/log/audit    <fstype>     defaults,rw,nosuid,nodev,noexec,relatime  0 0|' /etc/fstab; mount -o remount /var/log/audit; exit 0
