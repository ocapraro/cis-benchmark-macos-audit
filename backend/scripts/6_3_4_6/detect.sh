find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root 2>/dev/null || echo "Nothing should be returned"
