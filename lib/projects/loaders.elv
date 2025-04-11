use os
use path

var project-loaders = [
  &package.json={
    use ./node-js
    put $node-js:load-project~
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
    put { |directory| gradle:load-project $directory build.gradle }
  }

  &build.gradle.kts={
    use ./gradle
    put { |directory| gradle:load-project $directory build.gradle.kts }
  }

  &pyproject.toml={
    use ./python
    put $python:load-project~
  }
]

fn get-for &descriptor-name=$nil { |directory|
  keys $project-loaders | each { |current-descriptor-name|
    if (or
      (eq $current-descriptor-name $descriptor-name)
      (os:is-regular (path:join $directory $current-descriptor-name))
    ) {
      put $project-loaders[$current-descriptor-name]
      return
    }
  }

  use ./unknown
  if (not $descriptor-name) {
    fail 'Descriptor file name must be specified for unknown technology!'
  }

  put { |directory| unknown:create-project $directory $descriptor-name }
}