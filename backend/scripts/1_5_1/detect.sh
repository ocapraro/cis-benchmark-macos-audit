grep -Psi -- '^\h*\*\h+hard\h+core\b' /etc/security/limits.conf /etc/security/limits.d/* 2>/dev/null | grep -v '0' || echo ""
