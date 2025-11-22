#!/bin/bash
# Add nodev option to /home mount point
# Note: This requires a reboot to take effect as /home cannot be remounted while in use

# Check if /home is a separate mount point
if ! findmnt -kn /home >/dev/null 2>&1; then
    echo "Warning: /home is not a separate partition. This check may not apply."
    exit 0
fi

# Get the current mount options
current_options=$(findmnt -kn -o OPTIONS /home)

# Check if nodev is already present
if echo "$current_options" | grep -q "nodev"; then
    echo "/home already has nodev option"
    exit 0
fi

# Add nodev to fstab if /home entry exists
if grep -q "^[^#]*[[:space:]]/home[[:space:]]" /etc/fstab; then
    # Backup fstab
    cp /etc/fstab /etc/fstab.backup
    # Add nodev option
    sed -i '/^[^#]*[[:space:]]\/home[[:space:]]/ s/\(defaults\)/\1,nodev/' /etc/fstab
    echo "Added nodev to /home in /etc/fstab"
    echo "REBOOT REQUIRED for changes to take effect"
else
    echo "No /home entry found in /etc/fstab"
    exit 1
fi
