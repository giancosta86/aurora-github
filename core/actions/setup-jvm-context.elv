use os
use path
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/map
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env

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

  console:section &emoji=⚙️ 'PATHS BEFORE' {
    all $paths | each { |path|
      echo 📌 $path
    }
  }

  console:inspect &emoji=🌲 'SDKMAN_ENV BEFORE' $E:SDKMAN_ENV

  sdkman:setup-env

  console:section &emoji=📦 'CANDIDATES' {
    find ~/.sdkman/candidates -mindepth 2 -maxdepth 2
  }

  console:section &emoji=⚙️ 'PATHS AFTER' {
    all $paths | each { |path|
      echo 📌 $path
    }
  }

  console:inspect &emoji=🌲 'SDKMAN_ENV AFTER' $E:SDKMAN_ENV

  var home-dir-vars = [(
    sdkman:get-sdkfile-candidates |
      map:keys |
      each $sdkman:get-candidate-home-var~
  )]

  console:section &emoji=🏡 'HOME directories' {
    all $home-dir-vars | each { |home-dir-var|
      if (has-env $home-dir-var) {
        get-env $home-dir-var |
          console:inspect &emoji=📌 $home-dir-var (all)
      }
    }
  }

  {
    all $home-dir-vars
    put PATH
    put SDKMAN_ENV
  } |
    each $env:cascade~

  var build-context = (detect-build-context)

  console:inspect &emoji=🧰 'Build context' $build-context

  env:map $build-context

  echo ✅☕ JVM context in "'"$pwd"'" ready!
}