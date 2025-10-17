
/usr/bin/sudo /usr/sbin/chown -R root:wheel /etc/security/audit_control

/usr/bin/sudo /bin/chmod -R og-rw /etc/security/audit_control

/usr/bin/sudo /usr/sbin/chown -R root:wheel $(/usr/bin/sudo /usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}')

/usr/bin/sudo /bin/chmod -R og-rw $(/usr/bin/sudo /usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}')