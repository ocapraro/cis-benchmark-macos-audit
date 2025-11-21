sed -i '/^GSSAPIAuthentication/d' /etc/ssh/sshd_config; echo 'GSSAPIAuthentication no' >> /etc/ssh/sshd_config; systemctl restart sshd; exit 0
