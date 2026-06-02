use os
use github.com/giancosta86/ethereal/v1/lang

var -loader-retrievers = [
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
    put { gradle:load-project build.gradle }
  }

  &build.gradle.kts={
    use ./gradle
    put { gradle:load-project build.gradle.kts }
  }

  &pyproject.toml={
    use ./python
    put $python:load-project~
  }
]

fn -from-descriptor-name { |descriptor-name|
  echo 🔎 Requested descriptor: $descriptor-name

  var requested-retriever = (lang:get-value $-loader-retrievers $descriptor-name)

  if $requested-retriever {
    echo 📤 Fetching the requested loader for: $descriptor-name

    var loader = ($requested-retriever)
    put $loader
  } else {
    echo 🎁 Unknown technology found!

    use ./unknown
    put { unknown:load-project $descriptor-name }
  }
}

fn -infer-from-files {
  echo 🔎 Now looking for a supported descriptor...

  keys $-loader-retrievers | each { |current-descriptor-name|
    if (os:is-regular $current-descriptor-name) {
      echo 🌟 Descriptor found: $current-descriptor-name

      var loader = ($-loader-retrievers[$current-descriptor-name])
      put $loader

      return
    }
  }

  fail 'Unknown technology found - and no descriptor name was specified!'
}

fn load { |&descriptor-name=$nil|
  var loader-retriever = (
    lang:ternary $descriptor-name { -from-descriptor-name $descriptor-name } { -infer-from-files }
  )

  var loader = ($loader-retriever)

  $loader
}