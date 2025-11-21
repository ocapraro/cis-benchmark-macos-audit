findmnt -kn /var/tmp | grep -q '/var/tmp' && exit 0 || exit 1
