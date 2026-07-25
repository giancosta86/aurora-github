use path

cd (path:join .. .. .. .. tests rust-crate)

var expectation assertion = (
  get-env post-addendum |
    if (eq (all) true) {
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