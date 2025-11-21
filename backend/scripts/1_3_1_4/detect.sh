grep -Pi -- '^\h*SELINUX=(enforcing|permissive)\b' /etc/selinux/config | grep -q 'SELINUX=(enforcing|permissive)' && exit 0 || exit 1
