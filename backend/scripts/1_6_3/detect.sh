grep -Pi -- '^\\h*mac\\h*=\\h*([^#\\n\\r]+)?-128\\b' /etc/crypto-policies/state/CURRENT.pol || exit 1
