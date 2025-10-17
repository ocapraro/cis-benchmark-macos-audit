/usr/bin/sudo /bin/ls -n $(/usr/bin/sudo /usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}') | /usr/bin/awk '{s+=$3} END {print s}'

/usr/bin/sudo /bin/ls -n $(/usr/bin/sudo /usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}') | /usr/bin/awk '{s+=$4} END {print s}'

/usr/bin/sudo /bin/ls -l $(/usr/bin/sudo /usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}') | /usr/bin/awk '!/-r--r-----|current|total/{print $1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '

/usr/bin/sudo /bin/ls -n $(/usr/bin/sudo /usr/bin/grep '^dir' /var/audit/ | /usr/bin/awk -F: '{print $2}') | /usr/bin/awk '{s+=$3} END {print s}'

/usr/bin/sudo /bin/ls -n $(/usr/bin/sudo /usr/bin/grep '^dir' /var/audit/ | /usr/bin/awk -F: '{print $2}') | /usr/bin/awk '{s+=$4} END {print s}'

/usr/bin/sudo /bin/ls -l $(/usr/bin/sudo /usr/bin/grep '^dir' /var/audit/ | /usr/bin/awk -F: '{print $2}') | /usr/bin/awk '!/-r--r-----|current|total/{print $1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '