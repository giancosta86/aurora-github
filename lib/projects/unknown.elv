use ./base
use ./toml

fn load-project { |directory descriptor-name|
  base:load-project [
    &directory=$directory

    &technology=Unknown

    &icon=🎁

    &descriptor-name=$descriptor-name

    &version-retriever={ |descriptor-path| fail 'Cannot retrieve the version of an unknown technology!' }

    &build-tool=$nil
  ]
}
