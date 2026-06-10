use epm
use github.com/giancosta86/epm-plus/epm-plus
use ../epm-plus
use ./input

fn main {
  var packages = (input:list packages)

  epm-plus:install $@packages
}