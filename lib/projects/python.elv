use ./base
use ./toml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &technology=Python

    &icon=🐍

    &descriptor-name=pyproject.toml

    &version-retriever=$toml:read-version~

    &build-tool=pdm
  ]
}
