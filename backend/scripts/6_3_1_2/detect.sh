grubby --info=ALL | grep -Po '\baudit=1\b' && echo 'PASS' || echo 'FAIL'
