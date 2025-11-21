if [ $(stat -c '%a' /etc/ssh/sshd_config) -ge 600 ] && [ $(stat -c '%U' /etc/ssh/sshd_config) = 'root' ] && [ $(stat -c '%G' /etc/ssh/sshd_config) = 'root' ]; then exit 0; else exit 1; fi
