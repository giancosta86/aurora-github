use re
use ./base
use ./toml

fn load-project { |directory descriptor-name|
  base:load-project [
    &directory=$directory

    &descriptor-name=$descriptor-name

    &technology=Gradle

    &build-tool=gradle

    &emoji=🐘

    &version-reader=$toml:read-version~
  ]
}
