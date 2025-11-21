auditctl -l | grep -Ps -- '^\h*[^#\n\r]+\h*\/etc\/host' && echo 'PASS' || echo 'FAIL'
