use github.com/giancosta86/ethereal/v1/lang
use ../../std-err

fn run { |&quiet=$true @rest|
  var quiet-arg = (lang:ternary $quiet [-q] [])

  mvn -B $@quiet-arg $@rest
}

fn verify-project { |&quiet=$true|
  echo 🪶 Running Maven to verify the project...

  run &quiet=$quiet verify

  echo ✅ Maven verification OK!
}

fn publish-project { |&quiet=$true &dry-run=$true|
  var dry-run-arg

  if $dry-run {
    var dry-run-directory = target/dry-run

    std-err:inspect &emoji=📁 'dry-run mode enabled - publishing to local directory' $dry-run-directory

    set dry-run-arg = [-DaltDeploymentRepository=target-server::default::file:$dry-run-directory]
  } else {
    set dry-run-arg = []
  }

  run &quiet=$quiet $@dry-run-arg deploy
}