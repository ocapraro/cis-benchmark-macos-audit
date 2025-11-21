if [ $(find /home -type d -perm -007 -o ! -O) ]; then echo 'FAIL'; exit 1; else echo 'PASS'; exit 0; fi
