sed -i 's/\(<device> /home    <fstype>     \)defaults,\(.*\)/\1defaults,rw,nosuid,nodev,\2/' /etc/fstab; mount -o remount /home; exit 0;
