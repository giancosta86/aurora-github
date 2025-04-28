use ../lang
use ../console

fn run { |&quiet=$true @rest|
  var quiet-arg = (lang:ternary $quiet [-q] [])

  mvn -B $@quiet-arg $@rest
}

fn publish { |&quiet=$true dry-run|
  var dry-run-arg

  if $dry-run {
    var dry-run-directory = target/dry-run

    console:inspect &emoji=📁 'dry-run mode enabled - publishing to local directory' $dry-run-directory

    set dry-run-arg = [-DaltDeploymentRepository=target-server::default::file:$dry-run-directory]
  } else {
    set dry-run-arg = []
  }

  echo 🪶Running Maven to publish the project...

  run &quiet=$quiet $@dry-run-arg deploy

  echo ✅🪶Maven publication step successful!
}