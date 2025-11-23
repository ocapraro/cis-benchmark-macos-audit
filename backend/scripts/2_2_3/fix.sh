#!/bin/bash
# Remove telnet client
dnf remove -y telnet 2>/dev/null || yum remove -y telnet 2>/dev/null
