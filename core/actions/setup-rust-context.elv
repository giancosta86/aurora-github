use os
use ../ci-cd/env
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/lang
use ../std-err
use ./input

fn -check-preconditions {
  if (not (os:is-regular Cargo.toml)) {
    fail 'The Cargo.toml descriptor is missing!'
  }

  if (not (has-external cargo)) {
    fail 'Some version of Cargo must be installed!'
  }

  if (not (has-external rustup)) {
    fail 'Some version of rustup must be installed!'
  }
}

fn -set-cargo-colors { |enabled|
  env:write CARGO_TERM_COLOR (lang:ternary $enabled always never)
}

fn -check-toolchain-file {
  var toolchain-file = rust-toolchain.toml

  if (os:is-regular $toolchain-file) {
    std-err:inspect &emoji=✅ 'Toolchain file found' $toolchain-file
  } else {
    fail "Missing toolchain file: '"$toolchain-file"'"
  }
}

fn -ensure-required-components {
  command:silence {
    cargo --version

    rustup component add rustfmt clippy
  }
}

fn -print-component-versions {
  std-err:section &emoji=🦀 'Rust component versions' {
    cargo --version
    rustc --version
    cargo fmt --version
    cargo clippy --version
  }
}

fn main {
  var cargo-colors = (input:bool cargo-colors)

  var check-toolchain-file = (input:bool check-toolchain-file)

  std-err:echo 🦀💻 Setting up Rust context in "'"$pwd"'"...

  -check-preconditions

  -set-cargo-colors $cargo-colors

  if $check-toolchain-file {
    -check-toolchain-file
  }

  -ensure-required-components

  -print-component-versions

  std-err:echo ✅🦀 Rust context in "'"$pwd"'" ready!
}