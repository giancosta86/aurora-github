use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/seq

fn -check-includes-current-year { |license-file|
  var current-year = (date +%Y)

  if (seq:is-empty $current-year) {
    fail 'Cannot detect the current year!'
  }

  console:inspect &emoji=🗓 'Current year' $current-year

  console:echo 🔎🗓 Searching the license file for the current year...

  if ?(grep --color=always $current-year $license-file > &2) {
    console:echo ✅ Current year found in the license file!
  } else {
    fail 'Cannot find the current year in the license file!'
  }
}

fn check { |license-file|
  -check-includes-current-year $license-file
}
