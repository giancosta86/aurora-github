use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang

fn verify {
  console:echo 📦 Now running the 'verify' script from package.json...

  pnpm verify

  console:echo ✅Verification script OK!
}

fn publish { |dry-run|
  var dry-run-arg = (lang:ternary $dry-run [--dry-run] [])

  pnpm publish --no-git-checks --access public $@dry-run-arg
}
