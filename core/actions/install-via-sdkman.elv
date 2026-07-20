use os
use path
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/curl
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input

var sdkman~ = $sdkman:sdkman~

fn install-sdk { |candidate version|
  echo 📥 Installing $candidate'('$version')...'

  fs:with-path-sandbox curl:configuration-path {
    curl:display-errors-only

    command:silence {
      sdkman install $candidate $version
    }
  }

  echo ✅ $candidate'('$version')' installed!

  var sdk-bin = (
    sdkman:get-sdk-directory $candidate $version |
      path:join (all) bin
  )

  if (not (os:is-dir $sdk-bin)) {
    echo 💭 Inexistent SDK bin directory...
  } else {
    get-env PATH |
      put $sdk-bin':'(all) |
      env:set PATH

    echo ✅ SDK bin directory prepended to the PATH
  }
}

fn main {
  var candidate = (input:string candidate)

  var version = (input:string version)

  install-sdk $candidate $version
}