rpm -q bind 2>&1 | grep -q 'not installed' && echo "package bind is not installed" || echo "package bind is installed"
