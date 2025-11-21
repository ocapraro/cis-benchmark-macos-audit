systemctl is-enabled firewalld.service | grep -q 'enabled' && echo 'PASS' || echo 'FAIL'
