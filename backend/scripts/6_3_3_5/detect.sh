auditctl -l 2>/dev/null | grep -Ps -- 'sethostname|setdomainname' || echo ""
