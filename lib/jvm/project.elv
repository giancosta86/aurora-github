use ../project


var -build-tools = [mvn gradle]

fn detect { |project-directory|
  var project = (project:detect $project-directory)

  var build-tool = $project[build-tool]

  if (not (has-value $-build-tools $build-tool)) {
    fail 'Unsupported build tool for a JVM project: '$build-tool
  }

  put $project
}