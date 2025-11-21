rpm -q kea || systemctl show kea-dhcp-ddns.service kea-dhcp4.service kea-dhcp6.service -p UnitFileState,ActiveState | grep -Pi '=(enabled|active)'
