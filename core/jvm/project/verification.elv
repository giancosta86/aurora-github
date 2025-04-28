var -project-verifiers = [
  &mvn={ |quiet-tool|
    use ../maven
    maven:verify-project &quiet=$quiet-tool
  }

  &gradle={ |quiet-tool|
    use ../gradle
    gradle:verify-project &quiet=$quiet-tool
  }
]

fn verify { |&quiet-tool=$true build-tool|
  var verifier = $-project-verifiers[$build-tool]

  $verifier $quiet-tool
}