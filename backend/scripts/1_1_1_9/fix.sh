# To disable the firewire-core kernel module, run:
sudo modprobe -r firewire-core
# Ensure it is not loaded on boot by adding it to /etc/modprobe.d/blacklist.conf:
echo 'blacklist firewire-core' | sudo tee -a /etc/modprobe.d/blacklist.conf
# This is idempotent; running it multiple times will not change the state.
