use github.com/giancosta86/ethereal/v1/curl
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input
use ../jvm/sdkman

fn main {
  var candidate = (input:string candidate)

  var version = (input:string version)

  echo 📢 Configuring curl so that it outputs errors only...
  curl:display-errors-only

  sdkman:install-sdk $candidate $version

  get-env PATH |
    env:set PATH (all)
}