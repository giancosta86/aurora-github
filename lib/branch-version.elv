use re
use str
use path
use ./core
use ./console

fn detect {
  var head-ref = $E:GITHUB_HEAD_REF
  var ref = $E:GITHUB_REF

  var retrieved-branch = (
    core:ternary (not-eq $head-ref "") $head-ref $ref
  )

  if (eq $retrieved-branch "") {
    fail "Cannot retrieve the branch!"
  }

  console:inspect &icon=🌳 "Retrieved Git branch name" $retrieved-branch

  var branch = (path:base $retrieved-branch)
  console:inspect &icon=🌲 "Current Git branch" $branch

  var version = (str:trim-prefix $branch v)
  console:inspect &icon=🦋 "Detected version" $version

  var escaped-version = (re:quote $version)
  console:inspect &icon=🧵 "Escaped version" $escaped-version

  var major = (
    put $version |
      str:split . (all) |
      take 1 |
      str:split - (all) |
      take 1 |
      str:split + (all) |
      take 1
  )
  console:inspect &icon=🪩 "Major version" $major

  put [
    &branch=$branch
    &version=$version
    &escaped-version=$escaped-version
    &major=$major
  ]
}


