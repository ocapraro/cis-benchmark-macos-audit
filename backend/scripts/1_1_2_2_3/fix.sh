sed -i '/\/dev\/shm/s/defaults/defaults,nosuid/' /etc/fstab && mount -o remount /dev/shm
