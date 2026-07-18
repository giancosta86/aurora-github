>> 'The expected Maven version' {
  >> 'should not be installed' {
    capture {
      mvn --version
    } |
      should-not-contain (get-env expected-maven-version)
  }
}

>> 'The expected Gradle version' {
  >> 'should not be installed' {
    capture {
      gradle --version
    } |
      should-not-contain (get-env expected-gradle-version)
  }
}