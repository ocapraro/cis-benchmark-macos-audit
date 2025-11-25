#!/bin/bash
rpm -q xorg-x11-server-Xwayland 2>&1 | grep -q 'not installed' && echo 'not installed' || echo 'installed'
