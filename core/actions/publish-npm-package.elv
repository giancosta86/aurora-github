fn main {
  var dry-run-arg = (lang:ternary $dry-run [--dry-run] [])

  pnpm publish --no-git-checks --access public $@dry-run-arg
}