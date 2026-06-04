use github.com/giancosta86/ethereal/v1/seq
use ../branch-version
use ../ci-cd/action-references

fn main {
  var branch = (branch-version:detect)[branch]

  var regex = (action-references:get-regex-for-references-to-other-branches $branch)

  var grep-outcome = ?(
    grep --color=always --perl-regexp $regex **.yml > &2
  )

  if $grep-outcome {
    fail "There are references to actions within '"$pwd"' residing in other branches!"
  }

  var grep-exit-status = (
    seq:drill-down $grep-outcome reason exit-status
  )

  if (not-eq $grep-exit-status 1) {
    fail $grep-outcome
  }
}