use github.com/giancosta86/ethereal/v1/seq
use github.com/giancosta86/gauntlet/v1/action-references

fn main {
  var references-to-other-branches = [(
    action-references:get-to-other-branches &colors
  )]

  if (seq:is-non-empty $references-to-other-branches) {
    all $references-to-other-branches |
      each $echo~ >&2

    fail 'There are action references to other branches of this repository!'
  } else {
    echo ✅ No action references point to other branches of this repository
  }
}