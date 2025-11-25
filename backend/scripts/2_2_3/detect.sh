#!/bin/bash
rpm -q telnet 2>&1 | grep -q 'not installed' && echo 'not installed' || echo 'installed'
