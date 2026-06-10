use epm

if (not (epm:is-installed github.com/giancosta86/epm-plus)) {
  epm:install github.com/giancosta86/epm-plus
}

use github.com/giancosta86/epm-plus/epm-plus

fn install { |@packages|
  epm-plus:patch-epm

  all $packages | each { |package|
    if (not (epm:is-installed $package)) {
      epm:install $package
    }
  }
}