# If the udf kernel module is not needed, disable it by running:
sudo modprobe -r udf
# Ensure that the module is not loaded on boot by adding it to /etc/modprobe.d/blacklist.conf:
echo 'blacklist udf' | sudo tee -a /etc/modprobe.d/blacklist.conf
# This is idempotent; running it multiple times will not change the state.
