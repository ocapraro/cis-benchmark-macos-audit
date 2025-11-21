findmnt -kn /home | grep -v nodev || echo 'Nothing should be returned'
