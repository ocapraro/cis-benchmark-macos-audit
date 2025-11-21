findmnt -kn /var | grep -q '/var' && exit 0 || exit 1
