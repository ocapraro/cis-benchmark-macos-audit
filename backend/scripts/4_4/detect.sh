firewall-cmd --list-all | grep -q 'active' && echo 'PASS' || echo 'FAIL'
