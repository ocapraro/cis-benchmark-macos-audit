for user in $(awk -F: '($2 == "" ) { print $1 }' /etc/shadow); do passwd -l $user; done
