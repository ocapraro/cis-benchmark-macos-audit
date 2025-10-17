/usr/bin/sudo /usr/bin/osascript -l JavaScript << EOS
function run() {
  let pref1 = $.NSUserDefaults.alloc.initWithSuiteName('com.apple.alf').objectForKey('loggingenabled').js
  let pref2 = $.NSUserDefaults.alloc.initWithSuiteName('com.apple.alf').objectForKey('loggingoption').js
  if ( pref1 == 1 && pref2 == 2 ) {
    return("true")
  } else {
    return("false")
  }
}
EOS