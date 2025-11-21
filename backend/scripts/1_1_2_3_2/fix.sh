sed -i 's/\(\/home\s\+\S\+\s\+\S\+\s\+\)defaults/\1defaults,nodev/' /etc/fstab && mount -o remount /home
