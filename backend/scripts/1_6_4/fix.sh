# To disable CBC for SSH, edit the crypto policy file:
# vi /etc/crypto-policies/state/CURRENT.pol
# Ensure that CBC is not listed under the cipher settings.
# After editing, apply the changes:
# update-crypto-policies --set CURRENT
exit 0
