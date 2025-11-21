netstat -tuln | grep -v '127.0.0.1' | grep -v '::1' && echo 'PASS' || echo 'FAIL'
