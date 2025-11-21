grep -E 'log_group\s*=' /etc/audit/auditd.conf | grep -E '(adm|root)' && exit 0 || exit 1
