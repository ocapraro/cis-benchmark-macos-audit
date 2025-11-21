grep -Psi -- '^\\h*OPTIONS="?\\h*([^#\\n\\r]+\\h+)?-u\\h+root\\b' /etc/sysconfig/chronyd || exit 1
