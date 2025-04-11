use re
use ./base
use ./toml

fn load-project { |directory descriptor-name|
  base:load-project [
    &directory=$directory

    &technology=Gradle

    &emoji=🐘

    &descriptor-name=$descriptor-name

    &version-reader={ |descriptor-path|
      cat $descriptor-path | each { |line|
        var match = core:first-or-nil [(re:find '^version\s*=\s*["''](.*)["'']' $line)]

        if $match {
          put $match
          break
        }
      }
    }

    &build-tool=gradle
  ]
}
