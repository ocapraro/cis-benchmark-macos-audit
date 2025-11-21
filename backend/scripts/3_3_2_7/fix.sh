sysctl -w net.ipv6.conf.all.accept_ra=0; echo 'net.ipv6.conf.all.accept_ra=0' >> /etc/sysctl.conf; sysctl -p
