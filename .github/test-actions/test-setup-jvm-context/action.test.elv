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


>> 'Home variables' {
  >> 'Java' {
    get-env JAVA_HOME |
      should-be (sdkman:get-sdk-directory java current)
  }

  >> 'Maven' {
    get-env MAVEN_HOME |
      should-be (sdkman:get-sdk-directory maven current)
  }

  >> 'Gradle' {
    get-env GRADLE_HOME |
      should-be (sdkman:get-sdk-directory gradle current)
  }

  >> 'sbt' {
    get-env SBT_HOME |
      should-be (sdkman:get-sdk-directory sbt current)
  }
}