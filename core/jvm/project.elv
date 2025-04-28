use github.com/giancosta86/aurora-elvish/console
use ../project

var -supported-build-tools = [mvn gradle]

fn detect-for-jvm {
  var project = (project:detect)

  var build-tool = $project[build-tool]

  console:inspect &emoji=⚒ 'Project build tool' $build-tool

  if (not (has-value $-supported-build-tools $build-tool)) {
    fail 'Unsupported build tool for a JVM project: '$build-tool
  }

  put $project
}