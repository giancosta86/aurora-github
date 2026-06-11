use ../../std-err

fn check {
  std-err:echo 📚 Building rustdoc documentation with all the features enabled...

  tmp E:RUSTDOCFLAGS = '-D warnings'

  cargo doc --all-features

  std-err:echo ✅ Documentation built successfully!
}