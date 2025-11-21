echo 'server your_ntp_server iburst' >> /etc/chrony.conf && systemctl restart chronyd && exit 0
