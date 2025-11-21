# To disable the hfs kernel module, run:
sudo modprobe -r hfs
# Ensure it is not loaded on boot by blacklisting it:
echo 'blacklist hfs' | sudo tee /etc/modprobe.d/blacklist-hfs.conf
# Exit 0 if successful, 2 if manual steps are needed.
