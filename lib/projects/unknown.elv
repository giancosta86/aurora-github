use ./base
use ./toml

fn load-project { |directory descriptor-name|
  base:load-project [
    &directory=$directory

    &technology=Unknown

    &emoji=🎁

    &descriptor-name=$descriptor-name

    &version-reader={ |descriptor-path| put $nil }

    &build-tool=$nil
  ]
}
