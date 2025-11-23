grubby --info=ALL 2>/dev/null | grep -Po "\baudit_backlog_limit=\d+\b" || echo ""
