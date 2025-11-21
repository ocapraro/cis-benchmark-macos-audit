firewall-cmd --list-all | grep -q 'default-deny' && echo 'PASS' || echo 'FAIL'
