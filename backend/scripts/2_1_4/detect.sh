rpm -q kea 2>&1 | grep -q 'not installed' && echo "package kea is not installed" || echo "package kea is installed"
