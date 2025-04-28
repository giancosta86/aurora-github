use github.com/giancosta86/aurora-elvish/lang

fn publish { |dry-run|
  var dry-run-arg = (lang:ternary $dry-run [--dry-run] [])

  cargo publish --all-features --allow-dirty $@dry-run-arg
}