use ./input

var project-publishers = [
  &mvn={ |inputs|
    use ../jvm/maven
    maven:publish-project &quiet=$inputs[quiet-tool] &dry-run=$inputs[dry-run]
  }

  &gradle={ |inputs|
    use ../jvm/gradle
    gradle:publish-project &quiet=$inputs[quiet-tool] &dry-run=$inputs[dry-run]
  }
]

fn main {
  var quiet-tool = (input:bool quiet-tool)
  var dry-run = (input:bool dry-run)

  var build-tool = (get-env jvm-build-tool)

  var publisher = $-project-publishers[$build-tool]

  $publisher [
    &quiet-tool=$quiet-tool
    &dry-run=$dry-run
  ]
}