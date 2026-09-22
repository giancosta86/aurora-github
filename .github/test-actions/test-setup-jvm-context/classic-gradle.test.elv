>> 'Classic Gradle' {
  >> 'descriptor variable' {
    get-env jvm-descriptor |
      should-be build.gradle
  }

  >> 'build tool variable' {
    get-env jvm-build-tool |
      should-be gradle
  }
}