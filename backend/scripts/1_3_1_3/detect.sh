grep -Psi -- '^\h*SELINUXTYPE\\h*=\(targeted|mls)\' /etc/selinux/config && exit 0 || exit 1
