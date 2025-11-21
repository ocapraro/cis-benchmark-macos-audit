gawk -F= '($1~/^\s*(hash|sign)\s*$/ && $2~/SHA1/ && $2!~/^\s*\-\s*([^#\n\r]+)?SHA1/){print}' /etc/crypto-policies/state/CURRENT.pol | grep -q . && exit 1 || exit 0
