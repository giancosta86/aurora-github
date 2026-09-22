use os
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env

fn main {
  echo ⚙️💻 Setting up SDKMAN context in "'"$pwd"'"...

  if (not (os:is-regular $sdkman:sdk-file)) {
    fail 'Please, create a '$sdkman:sdk-file' file for SDKMAN'
  }

  sdkman:setup-env

  var home-dir-vars = [(
    sdkman:each-candidate $sdkman:get-candidate-home-var~
  )]

  console:section &emoji=🏡 'HOME directories' {
    all $home-dir-vars | each { |home-dir-var|
      get-env $home-dir-var |
        console:inspect &emoji=📌 $home-dir-var (all)
    }
  }

  {
    put PATH
    put SDKMAN_ENV
    all $home-dir-vars
  } |
    each $env:cascade~

  echo ✅⚙️ SDKMAN context in "'"$pwd"'" ready!
}