sed -i 's/^log_group.*/log_group = root/' /etc/audit/auditd.conf; systemctl restart auditd; exit 0
