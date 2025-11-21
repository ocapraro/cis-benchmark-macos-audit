systemctl list-unit-files | awk '$1~/^crond?\.service/{print $2}' | grep -q 'enabled' && systemctl list-units | awk '$1~/^crond?\.service/{print $3}' | grep -q 'active'
