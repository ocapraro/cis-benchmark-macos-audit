#!/bin/bash
grep -r 'gpgkey=' /etc/yum.repos.d/* /etc/dnf/dnf.conf 2>/dev/null | head -1 || echo ""
