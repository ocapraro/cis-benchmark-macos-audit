sed -i 's/\(\/var\/log\/audit\s\+.*\)\(defaults\)/\1\2,nosuid/' /etc/fstab; mount -o remount /var/log/audit; exit 0
