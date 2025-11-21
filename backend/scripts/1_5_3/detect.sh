sysctl fs.protected_symlinks | grep -q 'fs.protected_symlinks = 1' && exit 0 || exit 1
