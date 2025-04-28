use ./base
use ./descriptors/json

fn load-project {
  base:load-project [
    &descriptor-namespace=$json:

    &descriptor-name=package.json

    &technology=NodeJS

    &build-tool=pnpm

    &emoji=📦
  ]
}
