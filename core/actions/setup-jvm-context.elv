use os
use github.com/giancosta86/ethereal/v1/map
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input

var build-tools-by-descriptor = [
  &pom.xml=mvn
  &build.gradle=gradle
  &build.gradle.kts=gradle
]

var sdkman-candidates-by-build-tool = [
  &mvn=maven
  &gradle=gradle
]

fn detect-build-context {
  map:iterate $build-tools-by-descriptor { |descriptor build-tool|
    if (os:is-regular $descriptor) {
      put [
        &jvm-descriptor=$descriptor
        &jvm-build-tool=$build-tool
      ]
      return
    }
  }

  fail 'Cannot detect a supported JVM build tool for the project'
}

fn main {
  echo ☕💻 Setting up JVM context in "'"$pwd"'"...

  var java-version = (input:string &optional java-version)
  var tool-version = (input:string &optional tool-version)

  var build-context = (detect-build-context)

  env:map $build-context

  if $java-version {
    sdkman:install-sdk java $java-version
  }

  if $tool-version {
    var build-tool = $build-context[jvm-build-tool]

    var tool-candidate = $sdkman-candidates-by-build-tool[$build-tool]

    sdkman:install $tool-candidate $tool-version
  }

  echo ✅☕ JVM context in "'"$pwd"'" ready!
}