use ../../std-err

fn -run-vanilla-tests {
  std-err:echo 🔬 Running tests with no features enabled...
  cargo test
  std-err:echo ✅ Tests with no features OK!
}

fn -run-tests-with-all-features {
  std-err:echo 🔬 Running tests with all the features enabled...
  cargo test --all-features
  std-err:echo ✅ Tests with all the features OK!
}

fn run {
  -run-vanilla-tests

  -run-tests-with-all-features
}