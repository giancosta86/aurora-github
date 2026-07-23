use os
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/curl
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input

fn install-rustup {
  fs:with-path-sandbox $curl:configuration-path {
    echo 📥 Now installing rustup...

    command:silence {
      curl:display-errors-only

      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -- -y
    }

    echo 🚀 rustup installed!
  }
}

fn check-preconditions {
  if (not (os:is-regular Cargo.toml)) {
    fail 'The Cargo.toml descriptor is missing!'
  }

  if (has-external rustup) {
    echo 🌟 rustup available on the system!
  } else {
    install-rustup

    🦀 RUSTUP 🦀
    rustup --version
    🦀🦀🦀🦀🦀🦀

    🦀 CARGO 🦀
    cargo --version
    🦀🦀🦀🦀🦀
  }
}

fn set-cargo-colors { |enabled|
  env:set CARGO_TERM_COLOR (lang:ternary $enabled always never)
}

fn check-toolchain-file {
  var toolchain-file = rust-toolchain.toml

  if (os:is-regular $toolchain-file) {
    console:inspect &emoji=✅ 'Toolchain file found' $toolchain-file
  } else {
    fail "Missing toolchain file: '"$toolchain-file"'"
  }
}

fn ensure-required-components {
  command:silence {
    cargo --version

    rustup component add rustfmt clippy
  }
}

fn print-component-versions {
  console:section &emoji=🦀 'Rust component versions' {
    cargo --version
    rustc --version
    cargo fmt --version
    cargo clippy --version
  }
}

fn main {
  rm /home/runner/.cargo/bin/cargo
  rm /home/runner/.cargo/bin/rustup

  var cargo-colors = (input:bool cargo-colors)

  var check-toolchain-file = (input:bool check-toolchain-file)

  echo 🦀💻 Setting up Rust context in "'"$pwd"'"...

  check-preconditions

  set-cargo-colors $cargo-colors

  if $check-toolchain-file {
    check-toolchain-file
  }

  ensure-required-components

  print-component-versions

  echo ✅🦀 Rust context in "'"$pwd"'" ready!
}