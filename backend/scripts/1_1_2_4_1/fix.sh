#!/bin/bash
# This requires manual intervention - creating partitions cannot be automated
echo 'Manual intervention required:'
echo 'Ensure /var is mounted on a separate partition.'
echo 'Steps:'
echo '1. Create a new partition (e.g., using fdisk or parted)'
echo '2. Format the partition (e.g., mkfs.ext4 /dev/sdX)'
echo '3. Add entry to /etc/fstab'
echo '4. Mount the partition: mount /var'
exit 0
