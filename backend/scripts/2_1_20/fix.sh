#!/bin/bash
# Remove X Window System Xwayland server
dnf remove -y xorg-x11-server-Xwayland 2>/dev/null || yum remove -y xorg-x11-server-Xwayland 2>/dev/null
