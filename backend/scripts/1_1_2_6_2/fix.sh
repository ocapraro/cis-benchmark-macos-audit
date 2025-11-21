sed -i 's/\(\S\+ /var/log\s\+\S\+\s\+\S\+\s\+\)\S\+/\1defaults,rw,nosuid,nodev,noexec,relatime/' /etc/fstab && mount -o remount /var/log
