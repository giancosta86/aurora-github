use path
use github.com/giancosta86/ethereal/v1/rust
use github.com/giancosta86/gauntlet/v1/input
use ./verify-rust-crate/snippets

fn main {
  var run-clippy = (input:bool run-clippy)

  var check-rustdoc = (input:bool check-rustdoc)

  snippets:extract README.md (path:join tests 'readme_test_')

  rust:check &run-clippy=$run-clippy &check-rustdoc=$check-rustdoc
}