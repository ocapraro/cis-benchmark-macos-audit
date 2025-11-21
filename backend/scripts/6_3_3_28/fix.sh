echo 'Add the following rule to /etc/audit/rules.d/50-perm_chng.rules: -a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_chng'
