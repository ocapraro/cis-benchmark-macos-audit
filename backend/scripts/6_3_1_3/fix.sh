# Edit /etc/default/grub to set audit_backlog_limit=8192 or larger
# Update grub configuration
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
