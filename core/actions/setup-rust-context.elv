use os
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/curl
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input

fn check-toolchain-file {
  var toolchain-file = rust-toolchain.toml

  if (os:is-regular $toolchain-file) {
    console:inspect &emoji=✅ 'Toolchain file found' $toolchain-file
  } else {
    fail "Missing toolchain file: '"$toolchain-file"'"
  }
}

fn install-rust {
  fs:with-path-sandbox $curl:configuration-path {
    echo 📥 Now installing 🦀Rust core...

    curl:with-silence {
      command:silence {
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      }
    }

    echo 🚀 Rust core installed!
  }
}

fn ensure-rust-core {
  if (
    and (has-external rustup) (has-external cargo)
  ) {
    echo 🌟 rustup and cargo are available on the system!
  } else {
    install-rust
  }
}

fn check-edition {
  if (not (
    slurp < Cargo.toml |
      re:match '(?m)^edition\s+=\s+[\S]+' (all)
    )
  ) {
    fail 'Missing "edition" declaration in Cargo.toml!'
  }
}

fn set-cargo-colors { |enabled|
  env:set CARGO_TERM_COLOR (lang:ternary $enabled always never)
}


fn ensure-required-components {
  command:silence {
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
  var cargo-colors = (input:bool cargo-colors)

  echo 🦀💻 Setting up Rust context in "'"$pwd"'"...

  check-toolchain-file

  ensure-rust-core

  if (os:is-regular Cargo.toml) {
    check-edition
  }

  set-cargo-colors $cargo-colors

  ensure-required-components

  print-component-versions

  echo ✅🦀 Rust context in "'"$pwd"'" ready!
}