use str
use ../files

fn -check-format {
  echo 🎨Checking source code format...
  cargo fmt --check
  echo ✅Source code format OK!
}

fn -run-clippy-checks {
  echo 📎Running clippy checks...
  cargo clippy --all-targets --all-features -- -D warnings
  echo ✅Clippy checks OK!
}

fn check-style { |run-clippy-checks|
  -check-format

  if $run-clippy-checks {
    -run-clippy-checks
  }
}

fn -run-vanilla-tests {
  echo 🔬Running tests with no features enabled...
  cargo test
  echo ✅Tests with no features OK!
}

fn -run-tests-with-all-features {
  echo 🔬Running tests with all the features enabled...
  cargo test --all-features
  echo ✅Tests with all the features OK!
}

fn -build-rustdoc {
  echo 📚Running doctests with all the features enabled...
  tmp E:RUSTDOCFLAGS = '-D warnings'

  cargo doc --all-features

  echo ✅Rustdoc built successfully - with all the features enabled!
}

fn run-tests { |check-rustdoc|
  -run-vanilla-tests
  -run-tests-with-all-features

  if $check-rustdoc {
    -build-rustdoc
  }
}

fn document-all-features {
  files:edit Cargo.toml { |content|
    use str

    var descriptor-addendum = (str:join "\n" [
      '[package.metadata.docs.rs]'
      'all-features = true'
    ])

    put $content"\n\n"$descriptor-addendum
  }
}