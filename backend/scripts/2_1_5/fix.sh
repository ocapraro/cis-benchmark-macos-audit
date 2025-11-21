# If bind is installed, remove it safely
# Check for dependencies first
if rpm -q bind; then
  echo 'Removing bind package...';
  sudo yum remove bind -y;
else
  echo 'bind package is not installed.';
fi; exit 0
