echo 'Storage=none' >> /etc/systemd/coredump.conf; systemctl restart systemd-coredump.service; exit 0
