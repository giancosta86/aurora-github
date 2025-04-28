use ./base
use ./json

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &descriptor-name=package.json

    &technology=NodeJS

    &build-tool=pnpm

    &emoji=📦

    &version-reader=$json:read-version~

    &descriptor-printer=$json:print-descriptor~
  ]
}
