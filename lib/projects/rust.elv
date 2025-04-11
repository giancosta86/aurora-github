use ./base
use ./toml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &technology=Rust

    &icon=🦀

    &descriptor-name=Cargo.toml

    &version-reader=$toml:read-version~

    &build-tool=cargo
  ]
}
