use path

get-env GITHUB_WORKSPACE |
  path:join (all) tests rust-crate |
  cd (all)

var expectation assertion = (
  if (eq (get-env post-addendum) true) {
    all [
      'should contain the doc addendum'
      $should-contain~
    ]
  } else {
    all [
      'should not contain the doc addendum'
      $should-not-contain~
    ]
  }
)

>> 'Cargo.toml' {
  >> $expectation {
    slurp < Cargo.toml |
      $assertion package.metadata.docs.rs
  }
}