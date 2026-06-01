use github.com/giancosta86/ethereal/v1/map
use ./branch-version
use ./ci-cd/action-references

fn check {
  var branch = (branch-version:detect)[branch]

  var regex = (action-references:get-regex-for-references-to-other-branches $branch)

  var grep-result = ?(
    grep --color=always --perl-regexp $regex **.yml > &2
  )

  if $grep-result {
    fail "There are references to actions within '"$pwd"' residing in other branches!"
  } else {
    if (==s (map:drill-down &default='' $grep-result reason exit-status) 1) {
      console:echo ✅ No cross-branch action references detected!
    } else {
      fail $grep-result
    }
  }
}