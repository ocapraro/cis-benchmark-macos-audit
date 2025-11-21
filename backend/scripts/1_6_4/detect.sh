grep -Pi -- '^	h*cipher	h*=	h*([^#
]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol && grep -Pi -- '^	h*cipher@(lib|open)ssh(-server|-client)?	h*=	h*([^#
]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol
