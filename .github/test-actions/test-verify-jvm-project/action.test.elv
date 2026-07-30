use path

var version = (get-env version)

get-env GITHUB_WORKSPACE |
  path:join (all) tests |
  cd (all)

>> 'Running code' {
  >> 'from Maven project' {
    tmp pwd = maven-project

    java -jar target/maven-project-$version.jar |
      should-be 'Hello, world - from Kotlin and Maven! 🥳'
  }

  >> 'from Gradle project' {
    tmp pwd = gradle-project

    java -jar build/libs/gradle-project-$version.jar |
      should-be 'Hello, world - from Kotlin and Gradle! 🥳'
  }
}