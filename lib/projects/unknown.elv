use ./base

fn load-project { |directory descriptor-name|
  base:load-project [
    &directory=$directory

    &descriptor-name=$descriptor-name

    &technology=Unknown

    &build-tool=$nil

    &emoji=🎁

    &version-reader={ |_| put $nil }
  ]
}
