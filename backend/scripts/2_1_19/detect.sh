dnf grouplist | sed -n '/Installed Environment Groups:/,/Installed Groups:/p' | grep 'Server' && exit 1 || exit 0
