grep -Psi -- '^\\h*SELINUXTYPE\\h*=\\h*(targeted|mls)\\b' /etc/selinux/config && exit 0 || exit 1
