#!/bin/bash
# This requires manual intervention - creating partitions cannot be automated
echo 'Manual intervention required:'
echo 'Ensure /var/log/audit is mounted on a separate partition.'
echo 'Steps:'
echo '1. Backup existing data in /var/log/audit'
echo '2. Create a new partition (e.g., using fdisk or parted)'
echo '3. Format the partition (e.g., mkfs.ext4 /dev/sdX)'
echo '4. Add entry to /etc/fstab'
echo '5. Mount the partition: mount /var/log/audit'
echo '6. Restore backed up data'
exit 0
