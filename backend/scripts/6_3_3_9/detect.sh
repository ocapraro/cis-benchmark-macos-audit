auditctl -l | grep -Ps -- '\/etc/NetworkManager' && echo 'PASS' || echo 'FAIL'
