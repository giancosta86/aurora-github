use ./base
use ./toml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &descriptor-name=Cargo.toml

    &technology=Rust

    &build-tool=cargo

    &emoji=🦀

    &version-reader=$toml:read-version~
  ]
}
