sysctl -w net.ipv4.conf.all.accept_redirects=0; echo 'net.ipv4.conf.all.accept_redirects=0' >> /etc/sysctl.conf; sysctl -p
