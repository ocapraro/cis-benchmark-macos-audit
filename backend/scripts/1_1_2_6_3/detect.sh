findmnt -kn /var/log | grep -v nosuid; if [ $? -eq 0 ]; then exit 1; else exit 0; fi
