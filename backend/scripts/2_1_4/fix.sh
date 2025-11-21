# If kea package is installed and not needed, remove it:
sudo yum remove kea
# If services are active, stop and mask them:
sudo systemctl stop kea-dhcp-ddns.service kea-dhcp4.service kea-dhcp6.service
sudo systemctl mask kea-dhcp-ddns.service kea-dhcp4.service kea-dhcp6.service
