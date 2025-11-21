grep -E 'server|pool' /etc/chrony.conf | grep -E 'your_ntp_server' && exit 0 || exit 1
