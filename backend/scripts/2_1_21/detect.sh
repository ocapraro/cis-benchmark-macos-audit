ss -tuln | grep -v '127.0.0.1' | grep -v '::1' && echo 'listening on non-loopback address' || echo 'not listening on any non-loopback address'
