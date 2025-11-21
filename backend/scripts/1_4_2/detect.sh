find -L /boot/grub2/ -mindepth 1 -maxdepth 1 -type f -exec stat -Lc '%n:%#a:%U:%G' {} + | grep -E '^.*:0600:root:root$'
