#!/bin/bash
rpm -q openldap-clients 2>&1 | grep -q 'not installed' && echo 'not installed' || echo 'installed'
