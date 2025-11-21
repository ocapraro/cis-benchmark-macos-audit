sed -i 's/^SELINUX=.*$/SELINUX=enforcing/' /etc/selinux/config; setenforce 1; exit 0
