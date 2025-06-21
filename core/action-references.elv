use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/map
use ./branch-version/detection
use ./ci-cd/action-references

fn check {
  var branch = (detection:detect)[branch]

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