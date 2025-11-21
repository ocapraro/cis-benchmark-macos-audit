# Ensure /var/log/audit is on a separate partition
# 1. Backup existing data
# 2. Create a new partition
# 3. Format the new partition
# 4. Mount the new partition to /var/log/audit
# 5. Update /etc/fstab to ensure it mounts on boot
# 6. Restore data to /var/log/audit
