use os
use github.com/giancosta86/ethereal/v1/seq
use ./input

fn -check-current-year-included { |license-file|
  var current-year = (date +%Y)

  if (seq:is-empty $current-year) {
    fail 'Cannot detect the current year!'
  }

  echo 🗓 Current year: $current-year

  echo 🔎🗓 Searching the license file for the current year...

  if ?(grep --color=always $current-year $license-file > &2) {
    echo ✅ Current year found in the license file!
  } else {
    fail 'Cannot find the current year in the license file!'
  }
}

fn main {
  var license-file = (input:string license-file)

  if (os:is-regular $license-file) {
    -check-current-year-included $license-file
  } else {
    echo 💭 License file not found: $license-file
  }
}
