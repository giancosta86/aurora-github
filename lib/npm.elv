use str
use ./console
use ./core

fn parse-scope { |declared-scope|
  if (==s $declared-scope '<ROOT>') {
    console:print 🫚Root npm scope detected!
    put ''
  } else {
    if (core:empty $declared-scope) {
      fail "The declared scope cannot be empty!"
    }

    var actual-scope = (str:trim-prefix $declared-scope @)
    console:inspect &emoji=🖌 "Custom npm scope detected" $actual-scope
    put $actual-scope
  }
}
