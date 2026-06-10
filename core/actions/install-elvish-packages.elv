use ../epm-plus
use ./input

fn main {
  var packages = (input:list packages)

  epm-plus:install $@packages
}