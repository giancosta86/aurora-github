use os

var -supported-descriptors = [
  build.gradle.kts
  build.gradle
]

fn get-name {
  for descriptor $-supported-descriptors {
    if (os:is-regular $descriptor) {
      put $descriptor
      return
    }
  }

  fail 'No supported Gradle descriptor found in '''$pwd'''!'
}