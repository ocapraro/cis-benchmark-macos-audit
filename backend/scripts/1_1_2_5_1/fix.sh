# For new installations, create a custom partition setup and specify a separate partition for /var/tmp.
# For existing systems, create a new partition and update /etc/fstab accordingly.
# Example steps:
# 1. Create a new partition using a tool like fdisk or parted.
# 2. Format the new partition (e.g., mkfs.ext4 /dev/sdb).
# 3. Update /etc/fstab with the new partition details.
exit 2
