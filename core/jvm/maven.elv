use path
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/highlight
use github.com/giancosta86/ethereal/v1/lang
use ./maven/settings

fn run { |&quiet=$true @arguments|
  var quiet-arg = (lang:ternary $quiet [-q] [])

  mvn -B $@quiet-arg $@arguments
}

fn verify-project { |&quiet=$true|
  echo 🪶 Running Maven to verify the project...

  run &quiet=$quiet verify

  echo ✅ Maven verification OK!
}

fn -print-descriptor {
  console:section &emoji=🪶 'pom.xml descriptor just before publication' {
    highlight:file pom.xml xml
  }
}

fn publish-project { |&quiet=$true &dry-run=$true|
  settings:prepare-for-publication

  -print-descriptor

  var fake-publish-arg = (
    if $dry-run {
      var fake-publish-directory = (
        path:join target fake-publish
      )

      console:inspect &emoji=📁 'dry-run mode enabled - publishing to local directory' $fake-publish-directory >&2

      put [
        -DaltDeploymentRepository=target-server::default::file:$fake-publish-directory
      ]
    } else {
      put []
    }
  )

  run &quiet=$quiet $@fake-publish-arg deploy
}