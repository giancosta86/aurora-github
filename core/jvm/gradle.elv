use github.com/giancosta86/ethereal/v1/lang

fn run { |&quiet=$true @rest|
  var quiet-arg = (lang:ternary $quiet [-q] [])

  gradle --no-daemon --no-scan $@quiet-arg $@rest
}

fn verify-project { |&quiet=$true|
  echo 🐘 Running Gradle to verify the project...

  run &quiet=$quiet build

  echo ✅ Gradle verification OK!
}

fn publish-project { |&quiet=$true &dry-run=$true|
  echo 🐘 Running Gradle to publish the project...

  var dry-run-arg = (lang:ternary $dry-run [--dry-run] [])

  run &quiet=$quiet $@dry-run-arg publish
}