# To disable the hfsplus kernel module, run:
sudo modprobe -r hfsplus
# If it is built into the kernel, ensure it is not loaded by checking:
lsmod | grep hfsplus
# If it is loaded, you may need to rebuild the kernel without hfsplus support.
