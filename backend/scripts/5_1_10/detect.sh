sshd -T | grep hostbasedauthentication | grep -q 'hostbasedauthentication no' && exit 0 || exit 1
