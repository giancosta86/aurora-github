use os
use ../console
use ../env
use ../lang

fn set-cargo-colors { |enabled|
  var key = CARGO_TERM_COLOR
  var value = (lang:ternary $enabled always never)

  set-env $key $value
  env:write $key $value
}

fn check-toolchain-file {
  var toolchain-file = rust-toolchain.toml

  if (os:is-regular $toolchain-file) {
    console:inspect &emoji=✅ 'Toolchain file found' $toolchain-file
  } else {
    fail "Missing toolchain file: '"$toolchain-file"'"
  }
}

fn print-toolchain-versions {
  cargo --version > /dev/null 2>&1

  console:section &emoji=🦀 'Rust toolchain versions' {
    cargo --version
    rustc --version
    cargo fmt --version
    cargo clippy --version
  }
}
