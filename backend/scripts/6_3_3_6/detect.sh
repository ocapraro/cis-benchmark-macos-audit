auditctl -l | grep -Ps -- '^\h*[^#\n\r]+\h*\/etc\/issue' && echo 'PASS' || echo 'FAIL'
