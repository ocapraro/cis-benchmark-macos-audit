sed -n '/\[daemon\]/,/\\[/p' /etc/gdm/custom.conf | grep -Psi '^\h*waylandenable\b' | grep -q 'WaylandEnable=false' && exit 0 || exit 1
