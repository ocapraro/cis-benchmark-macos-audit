sed -i 's/\(\/var\/log\s\+.*\)\(\s\+defaults\)/\1,noexec\2/' /etc/fstab; mount -o remount /var/log; exit 0;
