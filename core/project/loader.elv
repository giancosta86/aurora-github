use os
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang
use github.com/giancosta86/aurora-elvish/map

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
  console:inspect 'Requested descriptor' $descriptor-name

  var requested-retriever = (map:get-value $-loader-retrievers $descriptor-name)

  if $requested-retriever {
    console:inspect &emoji=📤 'Fetching the requested loader for' $descriptor-name

    var loader = ($requested-retriever)
    put $loader
  } else {
    console:echo 🎁 Unknown technology found!

    use ./unknown
    put { unknown:load-project $descriptor-name }
  }
}

fn -infer-from-files {
  console:echo 🔎 Now looking for a supported descriptor...

  keys $-loader-retrievers | each { |current-descriptor-name|
    if (os:is-regular $current-descriptor-name) {
      console:inspect &emoji=🌟 'Descriptor found' $current-descriptor-name

      var loader = ($-loader-retrievers[$current-descriptor-name])
      put $loader

      return
    }
  }

  fail 'Unknown technology found - and no descriptor name was specified!'
}

fn load { |&descriptor-name=$nil|
  var loader-retriever = (lang:ternary $descriptor-name { -from-descriptor-name $descriptor-name } { -infer-from-files })

  var loader = ($loader-retriever)

  $loader
}