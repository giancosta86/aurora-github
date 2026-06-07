use epm
use str

fn main {
  var packages = ({
    if (has-env packages) {
      get-env packages
    } else {
      fail 'Missing input: packages'
    }
  })

  if (not (epm:is-installed github.com/giancosta86/epm-plus)) {
    epm:install github.com/giancosta86/epm-plus
  }

  use github.com/giancosta86/epm-plus/epm-plus
  epm-plus:patch-epm

  str:split , $packages |
    each str:trim-space~ |
    each { |package|
      if (not (epm:is-installed $package)) {
        epm:install $package
      }
  }
}