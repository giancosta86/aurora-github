use github.com/giancosta86/aurora-elvish/console
use ./project
use ./sdkman

var -build-tool-sdks = [
  &mvn=maven
  &gradle=gradle
]

fn setup { |&java-version=$nil &tool-version=$nil|
  console:inspect-inputs [
    &java-version=$java-version
    &tool-version=$tool-version
  ]

  console:echo ☕💻 Setting up JVM context in "'"$pwd"'"...

  var project = (project:detect-for-jvm)
  var build-tool = $project[build-tool]

  if $java-version {
    sdkman:install-sdk java $java-version
  }

  if $tool-version {
    var build-tool-sdk = $-build-tool-sdks[build-tool]

    sdkman:install $build-tool-sdk $tool-version
  }

  put [
    &buildTool=$build-tool
  ]

  console:echo ✅☕ JVM context in "'"$pwd"'" ready!
}