grep ^repo_gpgcheck /etc/dnf/dnf.conf | grep -q 'repo_gpgcheck=1' && exit 0 || exit 1
