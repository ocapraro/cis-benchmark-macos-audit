sed -i '/sha1_in_certs/d' /etc/crypto-policies/state/CURRENT.pol; echo 'sha1_in_certs = 0' >> /etc/crypto-policies/state/CURRENT.pol; update-crypto-policies; exit 0
