systemctl is-active firewalld.service | grep 'active' && echo 'PASS' || echo 'FAIL'
