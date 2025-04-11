use ./base
use ./json

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &technology=NodeJS

    &emoji=📦

    &descriptor-name=package.json

    &version-reader=$json:read-version~

    &build-tool=pnpm

    &descriptor-printer=$json:print-descriptor~
  ]
}
