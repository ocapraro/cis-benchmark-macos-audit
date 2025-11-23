stat -L /etc/ssh/ssh_host_*_key 2>/dev/null | grep -E 'Access|Uid|Gid' || echo ""
