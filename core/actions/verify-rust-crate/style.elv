fn -check-format {
  echo 🎨 Checking source code format...
  cargo fmt --check
  echo ✅ Source code format OK!
}

fn -run-clippy {
  echo 📎 Running clippy checks...
  cargo clippy --all-targets --all-features -- -D warnings
  echo ✅ Clippy checks OK!
}

fn check { |&run-clippy=$true|
  -check-format

  if $run-clippy {
    -run-clippy
  }
}
