auditctl -l | grep -Ps '^\h*[^#\n\r]+\h*\/usr\/bin\/setfacl' && echo 'PASS' || echo 'FAIL'
