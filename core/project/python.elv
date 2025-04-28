use ./base
use ./descriptors/toml

fn load-project {
  base:load-project [
    &descriptor-namespace=$toml:

    &descriptor-name=pyproject.toml

    &technology=Python

    &build-tool=pdm

    &emoji=🐍
  ]
}
