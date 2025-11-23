#!/bin/bash
# Set proper permissions on /etc/cron.yearly
if [ -d /etc/cron.yearly ]; then
    chown root:root /etc/cron.yearly
    chmod 700 /etc/cron.yearly
else
    mkdir -p /etc/cron.yearly
    chown root:root /etc/cron.yearly
    chmod 700 /etc/cron.yearly
fi
