sed -i 's/\(<device> /var\s\+<fstype>\s\+defaults\)/\1,nodev/' /etc/fstab && mount -o remount /var
