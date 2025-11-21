findmnt -kn /var | grep -v nosuid || exit 0; exit 1
