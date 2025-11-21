grep -Pi -- '^	h*cipher	h*=	h*([^#
]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol && exit 1 || exit 0
