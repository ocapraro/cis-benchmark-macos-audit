grep '^ProcessSizeMax=' /etc/systemd/coredump.conf 2>/dev/null || echo "ProcessSizeMax not set"
