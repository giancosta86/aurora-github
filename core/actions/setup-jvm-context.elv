use os
use path
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/map
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input

var sdk~ = $sdkman:sdk~

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

  if (os:is-regular $sdkman:sdk-file) {
    sdk env install

    sdkman:setup-jvm-homes

    all [
      PATH
      JAVA_HOME
      MAVEN_HOME
      GRADLE_HOME
      SBT_HOME
    ] |
      each $env:cascade~
  }

  detect-build-context |
    env:map

  echo ✅☕ JVM context in "'"$pwd"'" ready!
}