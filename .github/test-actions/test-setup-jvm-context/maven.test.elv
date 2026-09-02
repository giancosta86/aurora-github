>> 'Maven' {
  >> 'descriptor variable' {
    get-env jvm-descriptor |
      should-be pom.xml
  }

  >> 'build tool variable' {
    get-env jvm-build-tool |
      should-be mvn
  }
}