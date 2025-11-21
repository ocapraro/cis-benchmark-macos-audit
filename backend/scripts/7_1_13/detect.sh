find / -perm /6000 -exec ls -l {} \; | grep -E 'SUID|SGID'
