grep -Pi -- '^\h*gpgcheck\h*=\h*(1|true|yes)\b' /etc/dnf/dnf.conf && echo 'gpgcheck is enabled' || exit 1
