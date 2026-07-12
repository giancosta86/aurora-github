use github.com/giancosta86/ethereal/v1/seq
use ../ci-cd/action-references

fn main {
  var references-to-other-branches=(
    action-references:find-to-other-branches
  )

  if (seq:non-empty $references-to-other-branches) {
    all $references-to-other-branches | each { |reference|
      styled red bold $reference
    }

    fail "There are references to actions within '"$pwd"' residing in other branches!"
  }

  var grep-exit-status = (
    seq:drill-down $grep-outcome reason exit-status
  )

  if (not-eq $grep-exit-status 1) {
    fail $grep-outcome
  }
}