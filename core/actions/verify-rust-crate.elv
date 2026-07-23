use path
use github.com/giancosta86/gauntlet/v1/input
use ./verify-rust-crate/snippets
use ./verify-rust-crate/style
use ./verify-rust-crate/tests

fn check-rustdoc {
  echo 📚 Building rustdoc documentation with all the features enabled...

  tmp E:RUSTDOCFLAGS = '-D warnings'

  cargo doc --all-features

  echo ✅ Documentation built successfully!
}

fn main {
  var run-clippy = (input:bool run-clippy)

  var check-rustdoc = (input:bool check-rustdoc)

  style:check &run-clippy=$run-clippy

  if $check-rustdoc {
    check-rustdoc
  }

  snippets:extract README.md (path:join tests 'readme_test_')

  tests:run
}