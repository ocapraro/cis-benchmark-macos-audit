#!/bin/bash
rpm -q tftp 2>&1 | grep -q 'not installed' && echo 'not installed' || echo 'installed'
