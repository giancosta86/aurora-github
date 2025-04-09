use os
use ./console

fn -check-toolchain-file {
  var toolchain-file = rust-toolchain.toml

  if (os:is-regular $toolchain-file) {
    console:inspect &emoji=✅ 'Toolchain file found' $toolchain-file
  } else {
    fail "Missing toolchain file: '"$toolchain-file"'"
  }
}

fn -print-tool-versions {
  console:print-block &emoji=🦀 'Rust toolchain versions' {
    cargo --version
    rustc --version
    cargo fmt --version
    cargo clippy --version
  }
}

fn check-versions {
  -check-toolchain-file
  -print-tool-versions
}