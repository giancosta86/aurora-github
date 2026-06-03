use github.com/giancosta86/ethereal/v1/seq
use ./ci-cd/env
use ./std-err

fn -check-current-year-included { |license-file|
  var current-year = (date +%Y)

  if (seq:is-empty $current-year) {
    fail 'Cannot detect the current year!'
  }

  std-err:capture {
    echo 🗓 Current year: $current-year

    echo 🔎🗓 Searching the license file for the current year...
  }

  if ?(grep --color=always $current-year $license-file > &2) {
    std-err:echo ✅ Current year found in the license file!
  } else {
    fail 'Cannot find the current year in the license file!'
  }
}

fn check {
  var license-file = (env:file license-file)

  -check-current-year-included $license-file
}
