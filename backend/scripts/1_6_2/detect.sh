gawk -F= '($1~/^\s*(hash|sign)\s*$/ && $2~/SHA1/ && $2!~/^\s*\-\s*([^#\n\r]+)?SHA1/){print}' /etc/crypto-policies/state/CURRENT.pol 2>/dev/null || echo ""
