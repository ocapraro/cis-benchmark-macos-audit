# To disable the overlay kernel module, run the following command:
sudo modprobe -r overlayfs
# Ensure that the module is not loaded on boot by adding it to /etc/modprobe.d/blacklist.conf:
echo 'blacklist overlayfs' | sudo tee -a /etc/modprobe.d/blacklist.conf
# Verify that the module is disabled by running the detect script again.
