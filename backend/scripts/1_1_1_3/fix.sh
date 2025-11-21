# To disable the hfs kernel module, run:
sudo modprobe -r hfs
# Ensure it is not loaded on boot by adding it to /etc/modprobe.d/blacklist.conf:
echo 'blacklist hfs' | sudo tee -a /etc/modprobe.d/blacklist.conf
# Verify the module is not loaded:
lsmod | grep hfs
