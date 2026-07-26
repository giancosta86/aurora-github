use os
use github.com/giancosta86/ethereal/v1/map
use ../ci-cd/env
use ../jvm/sdkman
use ./input

var build-tool-by-descriptor = [
  &build.gradle.kts=gradle
  &build.gradle=gradle
  &pom.xml=mvn
]

var build-tool-sdks = [
  &mvn=maven
  &gradle=gradle
]

fn detect-build-context {
  map:iterate $build-tool-by-descriptor { |descriptor build-tool|
    if (os:is-regular $descriptor) {
      put [
        &descriptor=$descriptor
        &build-tool=$build-tool
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

  env:set jvm-descriptor $build-context[descriptor]
  env:set jvm-build-tool $build-context[build-tool]

  if $java-version {
    sdkman:install-sdk java $java-version
  }

  if $tool-version {
    var build-tool = $build-context[build-tool]

    var build-tool-sdk = $build-tool-sdks[$build-tool]

    sdkman:install $build-tool-sdk $tool-version
  }

  echo ✅☕ JVM context in "'"$pwd"'" ready!
}