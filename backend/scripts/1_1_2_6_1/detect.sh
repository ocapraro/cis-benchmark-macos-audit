#!/bin/bash
findmnt -kn /var/log 2>/dev/null || echo ""
