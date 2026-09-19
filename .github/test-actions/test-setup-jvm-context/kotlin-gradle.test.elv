>> 'Kotlin-based Gradle' {
  >> 'descriptor variable' {
    get-env jvm-descriptor |
      should-be build.gradle.kts
  }

  >> 'build tool variable' {
    get-env jvm-build-tool |
      should-be gradle
  }
}