#!/bin/bash
# Add repo_gpgcheck=1 to /etc/dnf/dnf.conf if not present
if ! grep -q '^repo_gpgcheck=1' /etc/dnf/dnf.conf; then
    sed -i '/^\[main\]/a repo_gpgcheck=1' /etc/dnf/dnf.conf
fi
