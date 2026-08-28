>> 'Version check' {
  >> 'JDK' {
    java -version |
      should-have-prefix 'openjdk version "1.8.0_502"'
  }

  >> 'Maven' {
    mvn -version |
      should-have-prefix 'Apache Maven 3.3.9'
  }

  >> 'Gradle' {
    gradle -version |
      should-contain 'Gradle 2.10'
  }
}