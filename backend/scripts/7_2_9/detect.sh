if ls -l ~/* | grep -E '0644|0600'; then exit 0; else exit 1; fi
