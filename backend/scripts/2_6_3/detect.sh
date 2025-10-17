/usr/bin/sudo /usr/bin/osascript -l JavaScript << EOS
function run() {
  let pref1 = ObjC.unwrap($.NSUserDefaults.alloc.initWithSuiteName('com.apple.loginwindow').objectForKey('autoLoginUser'))
  if ( pref1 == null ) {
    return("true")
  } else {
    return("false")
  }
}
EOS