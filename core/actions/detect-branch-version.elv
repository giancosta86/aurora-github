use re
use str
use github.com/giancosta86/ethereal/v1/semver
use github.com/giancosta86/gauntlet/v1/git-refs
use github.com/giancosta86/gauntlet/v1/output

fn main {
  var current-ref = (git-refs:get-current)

  var branch = [(str:split / $current-ref)][-1]

  var semantic-version = (semver:parse $branch)

  var version = (semver:to-string $semantic-version)

  var escaped-version = (re:quote $version)

  var major = $semantic-version[major]

  output:map [
    &branch=$branch
    &version=$version
    &escaped-version=$escaped-version
    &major=$major
  ]
}