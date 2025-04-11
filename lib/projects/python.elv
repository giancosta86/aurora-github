use ./base
use ./toml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &technology=Python

    &emoji=🐍

    &descriptor-name=pyproject.toml

    &version-reader=$toml:read-version~

    &build-tool=pdm
  ]
}
