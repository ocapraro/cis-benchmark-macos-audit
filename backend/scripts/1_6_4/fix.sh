echo 'Disabling CBC for SSH...'; sed -i 's/\(cipher\s*=\s*\)\(.*\)\(-CBC\b\)/\1\2/g' /etc/crypto-policies/state/CURRENT.pol; exit 0;
