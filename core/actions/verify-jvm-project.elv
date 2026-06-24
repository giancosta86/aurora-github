use ./input

var project-verifiers = [
  &mvn={ |quiet-tool|
    use ../jvm/maven
    maven:verify-project &quiet=$quiet-tool
  }

  &gradle={ |quiet-tool|
    use ../jvm/gradle
    gradle:verify-project &quiet=$quiet-tool
  }
]

fn main {
  var jvm-build-tool = (input:string jvm-build-tool)
  var quiet-tool = (input:bool quiet-tool)

  var verifier = $project-verifiers[$jvm-build-tool]

  $verifier $quiet-tool
}