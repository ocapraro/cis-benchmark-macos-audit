#!/bin/bash
# Remove LDAP client
dnf remove -y openldap-clients 2>/dev/null || yum remove -y openldap-clients 2>/dev/null
