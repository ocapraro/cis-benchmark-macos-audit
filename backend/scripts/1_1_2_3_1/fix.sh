# Ensure /home is a separate partition
# 1. Backup data
# 2. Resize existing partitions if necessary
# 3. Create a new partition for /home
# 4. Format the new partition
# 5. Mount the new partition to /home
# 6. Update /etc/fstab to ensure it mounts on boot
exit 2
