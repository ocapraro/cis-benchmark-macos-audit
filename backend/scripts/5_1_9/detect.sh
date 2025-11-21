sshd -T | grep gssapiauthentication | grep -q 'gssapiauthentication no' && exit 0 || exit 1
