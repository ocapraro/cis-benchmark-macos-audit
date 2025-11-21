if grep -q 'Storage=none' /etc/systemd/coredump.conf; then exit 0; else exit 1; fi
