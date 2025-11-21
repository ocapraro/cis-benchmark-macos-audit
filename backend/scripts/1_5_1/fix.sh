sed -ri '/^\s*[^#\n\r]+\s+hard\s+core\s+([1-9][0-9]*)/s/^/# /' /etc/security/limits.conf /etc/security/limits.d/*; printf '%s\n' "" "* hard core 0" >> /etc/security/limits.d/60-limits.conf
