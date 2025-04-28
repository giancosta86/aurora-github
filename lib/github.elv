use ./lang
use ./seq

fn actual-ref {
  var head-ref = (get-env GITHUB_HEAD_REF)
  var ref = (get-env GITHUB_REF)

  lang:ternary (seq:is-non-empty $head-ref) $head-ref $ref
}
