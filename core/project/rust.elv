use ./base
use ./descriptors/toml

fn load-project {
  base:load-project [
    &descriptor-namespace=$toml:

    &descriptor-name=Cargo.toml

    &technology=Rust

    &build-tool=cargo

    &emoji=🦀
  ]
}
