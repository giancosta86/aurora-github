var -project-publishers = [
  &mvn={ |inputs|
    use ../maven
    maven:publish-project &quiet=$inputs[quiet-tool] &dry-run=$inputs[dry-run]
  }

  &gradle={ |inputs|
    use ../gradle
    gradle:publish-project &quiet=$inputs[quiet-tool] &dry-run=$inputs[dry-run]
  }
]

fn publish { |&quiet-tool=$true &dry-run=$true build-tool|
  var publisher = $-project-publishers[$build-tool]

  $publisher [
    &quiet-tool=$quiet-tool
    &dry-run=$dry-run
  ]
}