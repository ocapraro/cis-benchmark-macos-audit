#!/bin/bash
# Remove TFTP client
dnf remove -y tftp 2>/dev/null || yum remove -y tftp 2>/dev/null
