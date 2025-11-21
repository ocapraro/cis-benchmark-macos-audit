findmnt -kn /var/log/audit | grep -v noexec; if [ $? -eq 0 ]; then exit 1; else exit 0; fi
