use ./base
use ./json

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &technology=NodeJS

    &icon=📦

    &descriptor-name=package.json

    &version-retriever=$json:read-version~

    &build-tool=pnpm

    &descriptor-printer=$json:print-descriptor~
  ]
}
