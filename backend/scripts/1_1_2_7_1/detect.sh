findmnt -kn /var/log/audit | grep -q '/var/log/audit' && exit 0 || exit 1
