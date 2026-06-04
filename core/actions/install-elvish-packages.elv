use epm
use str
use ./input

var packages = (input:string packages)

if (not (epm:is-installed github.com/giancosta86/epm-plus)) {
  epm:install github.com/giancosta86/epm-plus

  use github.com/giancosta86/epm-plus/epm-plus

  epm-plus:patch-epm
}

str:fields $packages |
  each { |package|
    if (not (epm:is-installed $package)) {
      epm:install $package
    }
  }