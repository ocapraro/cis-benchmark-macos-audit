dnf grouplist | sed -n '/Installed Environment Groups:/,/Installed Groups:/p' | grep -q 'GDM' && exit 1 || exit 0
