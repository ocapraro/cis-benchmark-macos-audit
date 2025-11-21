auditctl -l | grep execve | grep -q 'always,exit -C euid!=uid -F auid!=unset -S execve' && echo 'PASS' || echo 'FAIL'
