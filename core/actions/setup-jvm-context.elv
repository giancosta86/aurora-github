use os
use ../ci-cd/env
use ../jvm/sdkman
use ./input

var build-tool-sdks = [
  &mvn=maven
  &gradle=gradle
]

fn detect-build-tool {
  if (os:is-regular pom.xml) {
    put mvn
  } elif (os:is-regular build.gradle) {
    put gradle
  } elif (os:is-regular build.gradle.kts) {
    put gradle
  } else {
    fail 'Cannot detect a supported JVM build tool for the project'
  }
}

fn main {
  echo ☕💻 Setting up JVM context in "'"$pwd"'"...

  var java-version = (input:string &optional java-version)
  var tool-version = (input:string &optional tool-version)

  var build-tool = (detect-build-tool)
  env:write jvm-build-tool $build-tool

  if $java-version {
    sdkman:install-sdk java $java-version
  }

  if $tool-version {
    var build-tool-sdk = $build-tool-sdks[build-tool]

    sdkman:install $build-tool-sdk $tool-version
  }

  echo ✅☕ JVM context in "'"$pwd"'" ready!
}