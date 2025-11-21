auditctl -l | grep -Ps -- 'sethostname|setdomainname' && exit 0 || exit 1
