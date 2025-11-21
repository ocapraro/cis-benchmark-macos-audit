echo '-a always,exit -S sethostname,setdomainname' >> /etc/audit/rules.d/50-system_locale.rules && service auditd restart && exit 0
