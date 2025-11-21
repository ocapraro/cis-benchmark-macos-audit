iptables -L | grep -q 'DROP' && echo 'PASS' || echo 'FAIL'
