use os
use path

var project-loaders = [
  &package.json={
    use ./nodejs
    put $nodejs:load-project~
  }

  &Cargo.toml={
    use ./rust
    put $rust:load-project~
  }

  &pom.xml={
    use ./maven
    put $maven:load-project~
  }

  &build.gradle={
    use ./gradle
    put { |project-directory| gradle:load-project $project-directory build.gradle }
  }

  &build.gradle.kts={
    use ./gradle
    put { |project-directory| gradle:load-project $project-directory build.gradle.kts }
  }

  &pyproject.toml={
    use ./python
    put $python:load-project~
  }
]

fn get-for { |project-directory &descriptor-name=$nil|
  keys $project-loaders | each { |current-descriptor-name|
    var descriptor-matches = (==s $current-descriptor-name $descriptor-name)

    var descriptor-exists = (os:is-regular (path:join $project-directory $current-descriptor-name))

    if (or $descriptor-matches $descriptor-exists) {
      $project-loaders[$current-descriptor-name]
      return
    }
  }

  use ./unknown
  if (not $descriptor-name) {
    fail 'Descriptor file name must be specified for unknown technology!'
  }

  put { |_| unknown:load-project $project-directory $descriptor-name }
}