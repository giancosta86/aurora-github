use github.com/giancosta86/ethereal/v1/sdkman

>> 'Version check' {
  >> 'JDK' {
    capture {
      java -version
    } |
      should-have-prefix 'openjdk version "1.8.0_502"'
  }

  >> 'Maven' {
    capture {
      mvn --version
    } |
      should-have-prefix 'Apache Maven 3.3.9'
  }

  >> 'Gradle' {
    capture {
      gradle --version
    } |
      should-contain 'Gradle 2.10'
  }
}


>> 'Environment variables' {
  >> 'Java' {
    get-env JAVA_HOME |
      should-be (sdkman:get-sdk-directory java 8.0.502.fx-zulu)
  }

  >> 'Maven' {
    get-env MAVEN_HOME |
      should-be (sdkman:get-sdk-directory maven 3.3.9)
  }

  >> 'Gradle' {
    get-env GRADLE_HOME |
      should-be (sdkman:get-sdk-directory gradle 2.10)
  }

  >> 'sbt' {
    fail "-------> "(which sbt)

    get-env SBT_HOME |
      should-be (sdkman:get-sdk-directory sbt 0.13.18)
  }
}