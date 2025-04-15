use ./base
use ./toml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &descriptor-name=pyproject.toml

    &technology=Python

    &build-tool=pdm

    &emoji=🐍

    &version-reader=$toml:read-version~
  ]
}
