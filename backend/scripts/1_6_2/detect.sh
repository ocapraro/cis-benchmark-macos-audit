gawk -F= '($1~/^\s*(hash|sign)\s*$/ && $2~/SHA1/ && $2!~/^\s*\-\s*([^#\n\r]+)?SHA1/){print}' /etc/crypto-policies/state/CURRENT.pol; if [ $? -eq 0 ]; then exit 1; else exit 0; fi
