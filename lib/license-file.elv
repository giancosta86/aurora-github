use os
use ./console
use ./seq

fn -check-exists { |license-file|
  if (os:is-regular $license-file) {
    console:inspect &emoji=✅ "License file found" $license-file
  } else {
    fail "Missing license file: '"$license-file"'"
  }
}

fn -check-includes-current-year { |license-file|
  var current-year = (date +%Y)

  if (seq:is-empty $current-year) {
    fail 'Cannot detect the current year!'
  }

  console:inspect &emoji=🗓 'Current year' $current-year

  echo 🔎🗓Searching the license file for the current year...

  if ?(grep --color=always $current-year $license-file) {
    echo ✅Current year found in the license file!
  } else {
    fail 'Cannot find the current year in the license file!'
  }
}

fn check { |license-file|
  -check-exists $license-file

  -check-includes-current-year $license-file
}
