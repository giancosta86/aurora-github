use os
use use github.com/giancosta86/gauntlet/v1/env
use use github.com/giancosta86/gauntlet/v1/input

var verification-script = verify.elv

fn main {
  var verification-script-exists = (os:is-regular $verification-script)

  if $verification-script-exists {
    echo 📜 Verification script found! Now running it...

    elvish $verification-script
  }

  not $verification-script-exists |
    env:set run-velvet
}

fn run-velvet {
  var velvet-version = (input:string velvet-version)

  var velvet-scripts = (input:list velvet-scripts)

  echo 🐞 Running Velvet $velvet-version...

  var velvet-module: = (
    use-mod 'github.com/giancosta86/velvet/'$velvet-version'/velvet'
  )

  velvet-module:velvet &flawless $@velvet-scripts
}
