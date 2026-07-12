use re
use str
use github.com/giancosta86/ethereal/v1/semver
use github.com/giancosta86/ethereal/v1/seq
use ./ci-cd/git-refs

fn detect {
  var current-ref = (git-refs:get-current)

  var branch = [(str:split / $current-ref)][-1]

  var semantic-version = (semver:parse $branch)

  var version = (semver:to-string $semantic-version)

  var escaped-version = (re:quote $version)

  var major = $semantic-version[major]

  put [
    &current-ref=$current-ref
    &branch=$branch
    &version=$version
    &escaped-version=$escaped-version
    &major=$major
    &semantic-version=$semantic-version
  ]
}