sed -n '/\[daemon\]/,/\[/p' /etc/gdm/custom.conf 2>/dev/null | grep -Psi '^\h*waylandenable\b' || echo ""
