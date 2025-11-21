grep -Psi -- 'FirewallBackend\h*=\h*nftables\b' /etc/firewalld/firewalld.conf && exit 0 || exit 1
