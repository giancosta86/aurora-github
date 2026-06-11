use ../../std-err

fn -check-format {
  std-err:echo 🎨 Checking source code format...
  cargo fmt --check
  std-err:echo ✅ Source code format OK!
}

fn -run-clippy {
  std-err:echo 📎 Running clippy checks...
  cargo clippy --all-targets --all-features -- -D warnings
  std-err:echo ✅ Clippy checks OK!
}

fn check { |&run-clippy=$true|
  -check-format

  if $run-clippy {
    -run-clippy
  }
}
