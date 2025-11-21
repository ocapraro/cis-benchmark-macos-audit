# Ensure SELinux is enabled in the bootloader configuration
# Edit /etc/default/grub and ensure SELINUX is set to 'enforcing'
# Then run 'grub2-mkconfig -o /boot/grub2/grub.cfg' to apply changes
exit 0
