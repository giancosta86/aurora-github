>> 'The expected Maven version' {
  >> 'should be installed' {
    capture {
      mvn --version
    } |
      should-contain (get-env expected-maven-version)
  }
}

>> 'The expected Gradle version' {
  >> 'should be installed' {
    capture {
      gradle --version
    } |
      should-contain (get-env expected-gradle-version)
  }
}
