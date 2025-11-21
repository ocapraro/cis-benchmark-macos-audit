grep -Psi -- '^\\h*\*\\h+hard\\h+core\\b' /etc/security/limits.conf /etc/security/limits.d/* | grep -v 'hard core 0'
