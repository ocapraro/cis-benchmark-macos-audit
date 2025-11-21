grep -Pi -- '^\\h*mac\\h*=\\h*([^#\\n\\r]+)?-128\\b' /etc/crypto-policies/state/CURRENT.pol | grep -q . && exit 0 || exit 1
