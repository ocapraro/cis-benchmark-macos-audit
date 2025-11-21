sed -i 's/^FirewallBackend=.*/FirewallBackend=nftables/' /etc/firewalld/firewalld.conf; systemctl restart firewalld; exit 0
