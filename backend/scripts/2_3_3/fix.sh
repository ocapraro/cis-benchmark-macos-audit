sed -i 's/-u root//g' /etc/sysconfig/chronyd && systemctl reload-or-restart chronyd.service
