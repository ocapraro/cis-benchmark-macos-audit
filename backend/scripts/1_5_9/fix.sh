#!/bin/bash
# Set ProcessSizeMax=0 in coredump.conf
CONF_FILE="/etc/systemd/coredump.conf"

if [ ! -f "$CONF_FILE" ]; then
    # Create the file if it doesn't exist
    cat > "$CONF_FILE" << 'EOF'
[Coredump]
ProcessSizeMax=0
EOF
else
    # Check if [Coredump] section exists
    if ! grep -q '^\[Coredump\]' "$CONF_FILE"; then
        echo -e "\n[Coredump]\nProcessSizeMax=0" >> "$CONF_FILE"
    elif grep -q '^ProcessSizeMax=' "$CONF_FILE"; then
        # Update existing ProcessSizeMax
        sed -i 's/^ProcessSizeMax=.*/ProcessSizeMax=0/' "$CONF_FILE"
    else
        # Add ProcessSizeMax under [Coredump] section
        sed -i '/^\[Coredump\]/a ProcessSizeMax=0' "$CONF_FILE"
    fi
fi

systemctl daemon-reload 2>/dev/null
