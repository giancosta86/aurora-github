use ./branch-version
use ./console

fn check { |actions-directory|
  var branch = (branch-version:detect)[branch]

  var full-repo = $E:GITHUB_REPOSITORY
  if (eq full_repo "") {
    fail "Cannot detect the full repository name!"
  }
  console:inspect &icon=🧭 "Full repository name" $full-repo

  var reference-to-another-branch-regex = 'uses:\s*'$full-repo'[^@]+@(?!'$branch')'

  var grep-result = ?(
    grep --color=always -P $reference-to-another-branch-regex **/*.yml >&2
  )

  if $grep-result {
    fail "There are references to actions within '"$actions-directory"' residing in other branches!"
  } else {
    if (eq $grep-result[reason][exit-status] 1) {
      console:print ✅No cross-branch action references detected!
    } else {
      fail $grep-result
    }
  }
}