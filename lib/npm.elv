use str
use ./console

fn parse-scope { |declared-scope|
  if (eq $declared-scope '<ROOT>') {
    console:print 🫚Root npm scope detected!
    put ''
  } else {
    if (eq $declared-scope "") {
      fail "The declared scope cannot be empty!"
    }

    var actual-scope = (str:trim-prefix $declared-scope @)
    console:inspect &icon=🖌 "Custom npm scope detected" $actual-scope
    put $actual-scope
  }
}
