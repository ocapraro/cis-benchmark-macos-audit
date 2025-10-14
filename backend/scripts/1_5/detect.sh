/usr/bin/sudo /usr/bin/osascript -l JavaScript << EOS
$.NSUserDefaults.alloc.initWithSuiteName('com.apple.commerce')\
.objectForKey('AutoUpdate').js
EOS