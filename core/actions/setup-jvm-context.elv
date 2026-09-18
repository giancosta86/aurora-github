use os
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/map
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

  fail 'Cannot detect a supported JVM tool descriptor!'
}

fn main {
  echo ☕💻 Setting up JVM context in "'"$pwd"'"...

  var build-context = (detect-build-context)

  console:inspect &emoji=☕ 'JVM build context variables' $build-context

  env:map $build-context

  echo ✅☕ JVM context in "'"$pwd"'" ready!
}