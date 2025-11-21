printf '%s\n' "" "-c" >> /etc/audit/rules.d/01-initialize.rules; augenrules --load; if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then printf "Reboot required to load rules\n"; fi; exit 0;
