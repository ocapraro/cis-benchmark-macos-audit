findmnt -kn /var | grep -v nodev || echo 'Nothing should be returned'
