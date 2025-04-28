use ../lang

fn run { |&quiet=$true @rest|
  var quiet-arg = (lang:ternary $quiet [-q] [])

  gradle --no-daemon --no-scan $@quiet-arg $@rest
}