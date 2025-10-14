/usr/bin/sudo /usr/bin/osascript -l JavaScript << EOS
function run() {
  let firewallstate = ObjC.unwrap($.NSUserDefaults.alloc.initWithSuiteName('com.apple.alf').objectForKey('globalstate'))
  if ( ( firewallstate == 1 ) || ( firewallstate == 2 ) ) {
    return("true")
  } else {
    return("false")
  }
}
EOS