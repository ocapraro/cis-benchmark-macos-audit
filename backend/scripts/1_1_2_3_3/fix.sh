sed -i 's/\(\/home\s\+\S\+\s\+\S\+\s\+\)defaults/\1defaults,nosuid/' /etc/fstab; mount -o remount /home; exit 0
