# Ensure weak MACs are disabled in the crypto policy
# Edit /etc/crypto-policies/state/CURRENT.pol to remove or comment out any lines that set mac to a weak algorithm.
# Example: Comment out or remove lines containing '-128'.
exit 2
