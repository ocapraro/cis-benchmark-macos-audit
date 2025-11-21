sed -i 's/\(.*\/tmp.*\)\(defaults.*\)/\1\2,nodev/' /etc/fstab; mount -o remount /tmp; exit 0;
