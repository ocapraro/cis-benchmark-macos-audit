#!/bin/bash
findmnt -kn /var/log/audit 2>/dev/null || echo ""
