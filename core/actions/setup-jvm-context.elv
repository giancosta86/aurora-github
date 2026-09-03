use os
use path
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/map
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env

var sdk~ = $sdkman:sdk~

var home-dir-vars = [
  JAVA_HOME
  MAVEN_HOME
  GRADLE_HOME
  SBT_HOME
]

var build-tools-by-descriptor = [
  &pom.xml=mvn
  &build.gradle=gradle
  &build.gradle.kts=gradle
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

  put [
    &jvm-descriptor=$nil
    &jvm-build-tool=$nil
  ]

  echo '💭Cannot detect a supported JVM build tool for the project...' >&2
}

fn main {
  echo ☕💻 Setting up JVM context in "'"$pwd"'"...

  if (not (os:is-regular $sdkman:sdk-file)) {
    fail 'Please, create a '$sdkman:sdk-file' file for SDKMAN'
  }

  sdk env install

  sdkman:setup-jvm-homes

  console:section &emoji=🏡 'HOME directories' {
    all $home-dir-vars | each { |home-dir-var|
      if (has-env $home-dir-var) {
        get-env $home-dir-var |
          console:inspect &emoji=📌 $home-dir-var (all)
      }
    }
  }

  all [
    java
    maven
    gradle
    sbt
  ] | each { |candidate|
    var current-candidate-dir = (sdkman:get-sdk-directory $candidate current)

    if (
      os:exists $current-candidate-dir
    ) {
      set paths = [(
        path:join $current-candidate-dir bin
        all $paths
      )]
    }
  }

  console:section &emoji=⚙️ 'PATH' {
    get-env PATH |
      echo (all)
  }




  {
    all $home-dir-vars
    put PATH
  } |
    each $env:cascade~

  detect-build-context |
    env:map

  echo ✅☕ JVM context in "'"$pwd"'" ready!
}