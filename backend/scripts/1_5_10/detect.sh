grep 'Storage=' /etc/systemd/coredump.conf 2>/dev/null | grep -o 'Storage=.*' || echo "systemd-coredump Storage is set to none"
