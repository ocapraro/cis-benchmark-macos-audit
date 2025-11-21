# To disable the freevxfs kernel module, run:
sudo modprobe -r freevxfs
# Ensure it is not loaded on boot by adding it to /etc/modprobe.d/blacklist.conf:
echo 'blacklist freevxfs' | sudo tee -a /etc/modprobe.d/blacklist.conf
exit 0
