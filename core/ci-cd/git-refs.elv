use github.com/giancosta86/aurora-elvish/lang
use github.com/giancosta86/aurora-elvish/seq

fn get-actual {
  var head-ref = (get-env GITHUB_HEAD_REF)
  var ref = (get-env GITHUB_REF)

  lang:ternary (seq:is-non-empty $head-ref) $head-ref $ref
}
