# Ensure MTA is configured for local-only mode
# Edit the MTA configuration file (e.g., /etc/postfix/main.cf for Postfix)
# Set 'inet_interfaces = loopback-only'
# Restart the MTA service
systemctl restart postfix
