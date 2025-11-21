grep '^ProcessSizeMax=' /etc/systemd/coredump.conf | grep '0' && exit 0 || exit 1
