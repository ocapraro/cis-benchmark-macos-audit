grep -Pi -- '^\h*install_weak_deps\\h*=\(0|false|no)\' /etc/dnf/dnf.conf && exit 0 || exit 1
