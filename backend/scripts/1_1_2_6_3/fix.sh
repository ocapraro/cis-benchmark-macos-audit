sed -i 's/\(\/var\/log\s\+\S\+\s\+\S\+\s\+\)defaults/\1defaults,nosuid/' /etc/fstab; mount -o remount /var/log; exit 0;
