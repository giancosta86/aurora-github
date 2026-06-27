fn check {
  echo 📚 Building rustdoc documentation with all the features enabled...

  tmp E:RUSTDOCFLAGS = '-D warnings'

  cargo doc --all-features

  echo ✅ Documentation built successfully!
}