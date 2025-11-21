echo '-a always,exit -C euid!=uid -F auid!=unset -S execve' >> /etc/audit/rules.d/50-user_emulation.rules && service auditd restart
