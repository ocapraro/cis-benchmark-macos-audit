for i in $(/usr/bin/find /Users -type d -maxdepth 1); do
  PREF="$i/Library/Preferences/com.apple.Terminal"
  if [ -e "$PREF.plist" ]; then
    echo -n "Checking User: '$i': "
    /usr/bin/sudo /usr/bin/defaults read "$PREF.plist" SecureKeyboardEntry 2>/dev/null || echo "Not set"
  fi
done