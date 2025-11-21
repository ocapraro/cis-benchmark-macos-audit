sed -i 's/^HostbasedAuthentication yes/HostbasedAuthentication no/' /etc/ssh/sshd_config; systemctl restart sshd; exit 0;
