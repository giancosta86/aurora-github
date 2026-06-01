use github.com/giancosta86/ethereal/v1/seq

fn get-actual {
  var head-ref = (get-env GITHUB_HEAD_REF)

  if (seq:is-non-empty $head-ref) {
    put $head-ref
  } else {
    get-env GITHUB_REF
  }
}
