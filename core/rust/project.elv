use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/edit

fn -check-format {
  console:echo 🎨 Checking source code format...
  cargo fmt --check
  console:echo ✅ Source code format OK!
}

fn -run-clippy-checks {
  console:echo 📎 Running clippy checks...
  cargo clippy --all-targets --all-features -- -D warnings
  console:echo ✅ Clippy checks OK!
}

fn -check-rustdoc {
  console:echo 📚 Building rustdoc documentation with all the features enabled...

  tmp E:RUSTDOCFLAGS = '-D warnings'

  cargo doc --all-features

  console:echo ✅ Documentation built successfully!
}

fn check-style { |&run-clippy-checks=$true &check-rustdoc=$true|
  -check-format

  if $run-clippy-checks {
    -run-clippy-checks
  }

  if $check-rustdoc {
    -check-rustdoc
  }
}

fn -run-vanilla-tests {
  console:echo 🔬 Running tests with no features enabled...
  cargo test
  console:echo ✅ Tests with no features OK!
}

fn -run-tests-with-all-features {
  console:echo 🔬 Running tests with all the features enabled...
  cargo test --all-features
  console:echo ✅ Tests with all the features OK!
}

fn run-tests {
  -run-vanilla-tests

  -run-tests-with-all-features
}

fn document-all-features {
  edit:file Cargo.toml { |content|
    var docs-header = '[package.metadata.docs.rs]'

    if (str:contains $content $docs-header) {
      console:echo 💬 Skipping documentation addendum because $docs-header already appears in Cargo.toml...

      put $nil
    } else {
      console:echo 📚 Now adding the "'"all-features = true"'" documentation addendum to the project descriptor!

      var descriptor-addendum = (str:join "\n" [
        $docs-header
        'all-features = true'
      ])

      put (str:trim-space $content)"\n\n"$descriptor-addendum
    }
  }
}