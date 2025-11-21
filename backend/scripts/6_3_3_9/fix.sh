echo '-a always,exit -F dir=/etc/NetworkManager/ -F perm=wa -F key=network-manager' >> /etc/audit/rules.d/50-etc_NetworkManager.rules && service auditd restart
