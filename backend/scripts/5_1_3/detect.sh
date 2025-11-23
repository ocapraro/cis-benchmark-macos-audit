stat -L /etc/ssh/ssh_host_*_key.pub 2>/dev/null | grep 'Access' || echo ""
