use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/highlight
use github.com/giancosta86/ethereal/v1/lang
use ./gradle/settings

fn run { |&quiet=$true @arguments|
  var quiet-arg = (lang:ternary $quiet [-q] [])

  gradle --no-daemon --no-scan $@quiet-arg $@arguments
}

fn verify-project { |&quiet=$true|
  echo 🐘 Running Gradle to verify the project...

  run &quiet=$quiet build

  echo ✅ Gradle verification OK!
}

fn -print-descriptor {
  var descriptor = (get-env jvm-descriptor)

  console:section &emoji=🐘 'Gradle descriptor just before publication' {
    fs:split-ext $descriptor |
      drop 1 |
      lang:switch [
        &.kts={
          highlight:file $descriptor kotlin
        }
        &.gradle={
          highlight:file $descriptor groovy
        }
      ]
  }
}

fn publish-project { |&quiet=$true &dry-run=$true|
  settings:prepare-for-publication

  -print-descriptor

  echo 🐘 Running Gradle to publish the project...

  var dry-run-arg = (lang:ternary $dry-run [--dry-run] [])

  run &quiet=$quiet $@dry-run-arg publish
}