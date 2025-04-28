use path
use re
use str
use ../console
use ../lang
use ../seq
use ../github

fn detect {
  var actual-ref = (github:actual-ref)

  if (seq:is-empty $actual-ref) {
    fail 'Cannot retrieve the branch!'
  }

  console:inspect &emoji=🌳 'Full branch' $actual-ref

  if (seq:is-empty $actual-ref) {
    fail 'Cannot detect the Git ref!'
  }

  var branch = (path:base $actual-ref)
  console:inspect &emoji=🌲 'Current Git branch' $branch

  var version = (str:trim-prefix $branch v)
  console:inspect &emoji=🦋 'Detected version' $version

  var escaped-version = (re:quote $version)
  console:inspect &emoji=🧵 'Escaped version' $escaped-version

  var major = (
    str:split . $version |
      take 1 |
      str:split - (all) |
      take 1 |
      str:split + (all) |
      take 1
  )
  if (seq:is-empty $major) {
    fail 'The major version could not be detected!'
  }
  console:inspect &emoji=🪩 'Major version' $major

  put [
    &full-branch=$actual-ref
    &branch=$branch
    &version=$version
    &escaped-version=$escaped-version
    &major=$major
  ]
}
