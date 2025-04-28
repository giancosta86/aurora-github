use path
use re
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/semver
use github.com/giancosta86/aurora-elvish/seq
use ../ci-cd/git-refs

fn detect {
  var actual-ref = (git-refs:get-actual)

  if (seq:is-empty $actual-ref) {
    fail 'Cannot detect the actual Git ref!'
  }

  console:inspect &emoji=🌳 'Actual Git ref' $actual-ref

  var branch = (path:base $actual-ref)
  console:inspect &emoji=🌲 'Current Git branch' $branch

  var semantic-version = (semver:parse $branch)

  var version = (semver:to-string $semantic-version)
  console:inspect &emoji=🦋 'Detected version' $version

  var escaped-version = (re:quote $version)
  console:inspect &emoji=🧵 'Escaped version' $escaped-version

  var major = $semantic-version[major]
  console:inspect &emoji=🪩 'Major version' $major

  put [
    &full-branch=$actual-ref
    &branch=$branch
    &version=$version
    &escaped-version=$escaped-version
    &major=$major
    &semantic-version=$semantic-version
  ]
}
