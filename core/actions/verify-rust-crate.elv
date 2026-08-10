use path
use github.com/giancosta86/gauntlet/v1/input
use ./verify-rust-crate/rustdoc
use ./verify-rust-crate/snippets
use ./verify-rust-crate/style
use ./verify-rust-crate/tests

fn main {
  var run-clippy = (input:bool run-clippy)

  var check-rustdoc = (input:bool check-rustdoc)

  style:check &run-clippy=$run-clippy

  if $check-rustdoc {
    rustdoc:check
  }

  snippets:extract README.md (path:join tests 'readme_test_')

  tests:run
}