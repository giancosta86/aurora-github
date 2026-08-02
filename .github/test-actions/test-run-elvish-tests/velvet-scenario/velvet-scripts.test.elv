use os
use github.com/giancosta86/gauntlet/v1/repository

cd (repository:get-path tests elvish)

fn setup-test { |ordinal|
  >> $ordinal {
    var output-path = 'velvet-'$ordinal'.txt'

    var output-should-exist = (
      get-env $ordinal'-output-should-exist' |
        eq (all) true
    )

    if $output-should-exist {
      >> 'should exist' {
        put $output-path |
          should-be-regular
      }
    } else {
      >> 'should not exist' {
        put $output-path |
          should-not-be-regular
      }
    }
  }
}

>> 'Velvet test output' {
  all [
    first
    second
  ] |
    each $setup-test~
}
