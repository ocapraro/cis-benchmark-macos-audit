#!/bin/bash
# Set audit_backlog_limit in GRUB
GRUB_FILE="/etc/default/grub"
if [ -f "$GRUB_FILE" ]; then
    if grep -q 'GRUB_CMDLINE_LINUX.*audit_backlog_limit' "$GRUB_FILE"; then
        sed -i 's/audit_backlog_limit=[0-9]*/audit_backlog_limit=8192/' "$GRUB_FILE"
    else
        sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="audit_backlog_limit=8192 /' "$GRUB_FILE"
    fi
    # Update grub configuration
    if command -v grub2-mkconfig &>/dev/null; then
        grub2-mkconfig -o /boot/grub2/grub.cfg 2>/dev/null
    elif command -v grub-mkconfig &>/dev/null; then
        grub-mkconfig -o /boot/grub/grub.cfg 2>/dev/null
    fi
fi
