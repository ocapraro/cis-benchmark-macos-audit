echo 'ProcessSizeMax=0' >> /etc/systemd/coredump.conf && systemctl restart systemd-coredump.service && exit 0
