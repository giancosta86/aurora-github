use os
use re
use str
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/string
use ../ci-cd/output
use ./input

fn main {
  var files = (input:list files)

  var regex = (input:string regex)

  var crash-when = (
    input:enum &optional crash-when [found not-found]
  )

  var crash-message = (
    input:string &optional crash-message
  )

  var quiet = (input:bool quiet)

  var found = $false

  var quiet-grep-arg = (lang:ternary $quiet ['--quiet'] [])

  all $files | each { |file-wildcard|
    var escaped-wildcard = (string:escape-single-quotes $file-wildcard)

    var paths = [(eval 'put '$escaped-wildcard)]

    var grep-status = ?(
      grep --perl-regexp --color=always --with-filename --line-number $@quiet-grep-arg $regex $@paths >&2
    )

    if $grep-status {
      set found = $true
    }
  }

  if (and $found (eq $crash-when found)) {
    coalesce $crash-message 'Matches found!' |
      fail (all)
  } elif (and (not $found) (eq $crash-when not-found)) {
    coalesce $crash-message 'No matches found!' |
      fail (all)
  }

  output:write found $found
}