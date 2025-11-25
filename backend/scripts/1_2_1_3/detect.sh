#!/bin/bash
grep '^repo_gpgcheck' /etc/dnf/dnf.conf 2>/dev/null || echo ""
