use os
use ../ci-cd/env
use github.com/giancosta86/aurora-elvish/command
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang

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
  var key = CARGO_TERM_COLOR
  var value = (lang:ternary $enabled always never)

  set-env $key $value
  env:write $key $value
}

fn -check-toolchain-file {
  var toolchain-file = rust-toolchain.toml

  if (os:is-regular $toolchain-file) {
    console:inspect &emoji=✅ 'Toolchain file found' $toolchain-file
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
  console:section &emoji=🦀 'Rust component versions' {
    cargo --version
    rustc --version
    cargo fmt --version
    cargo clippy --version
  }
}

fn setup { |&cargo-colors=$true &check-toolchain-file=$true|
  console:echo 🦀💻 Setting up Rust context in "'"$pwd"'"...

  -check-preconditions

  -set-cargo-colors $cargo-colors

  if $check-toolchain-file {
    -check-toolchain-file
  }

  -ensure-required-components

  -print-component-versions

  console:echo ✅🦀 Rust context in "'"$pwd"'" ready!
}
