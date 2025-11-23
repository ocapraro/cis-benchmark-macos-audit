#!/bin/bash
# Disable GSSAPI authentication in SSH
if grep -q '^GSSAPIAuthentication' /etc/ssh/sshd_config; then
    sed -i 's/^GSSAPIAuthentication.*/GSSAPIAuthentication no/' /etc/ssh/sshd_config
else
    echo 'GSSAPIAuthentication no' >> /etc/ssh/sshd_config
fi
systemctl restart sshd 2>/dev/null || service sshd restart 2>/dev/null
