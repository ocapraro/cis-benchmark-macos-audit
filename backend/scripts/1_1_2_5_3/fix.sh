sed -i '/\/var\/tmp/s/defaults/defaults,nosuid/' /etc/fstab; mount -o remount /var/tmp; exit 0
