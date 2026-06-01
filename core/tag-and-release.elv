use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/semver
use ./branch-version
use ./ci-cd/pull-request
use ./git
use ./tag-and-release/git-log
use ./tag-and-release/major-tag
use ./tag-and-release/preconditions
use ./tag-and-release/release

fn -get-actual-draft-release { |draft-release semantic-version|
  if (==s $draft-release true) {
    put $true
    return
  }

  if (==s $draft-release false) {
    put $false
    return
  }

  semver:is-new-major $semantic-version
}

fn run-action { |inputs|
  console:inspect-inputs $inputs

  var draft-release = $inputs[draft-release]
  var notes-file-processor = $inputs[notes-file-processor]
  var set-major-tag = $inputs[set-major-tag]
  var dry-run = $inputs[dry-run]
  var git-strategy = $inputs[git-strategy]

  preconditions:check $dry-run

  var version-info = (branch-version:detect)
  var version = $version-info[version]
  var branch = $version-info[branch]
  var major = $version-info[major]
  var semantic-version = $version-info[semantic-version]

  var pull-request = (pull-request:fetch-info $branch)
  console:inspect &emoji=🔁 'Pull request' $pull-request

  git:hard-reset

  git-log:fetch $pull-request

  git:fetch-tags

  if (not $dry-run) {
    pull-request:merge $branch $git-strategy
  } else {
    console:echo 💭 Just simulating pull request merging, in dry-run mode...
  }

  var tag = v$version
  console:inspect &emoji=📌 'Tag to create' $tag

  if (not $dry-run) {
    git:create-and-push-tag $tag
  } else {
    console:echo 💭 Just simulating Git tag creation, in dry-run mode...
  }

  release:create [
    &tag=$tag
    &version=$version
    &dry-run=$dry-run
    &draft-release=(-get-actual-draft-release $draft-release $semantic-version)
    &notes-file-processor=$notes-file-processor
    &pull-request=$pull-request
  ]

  var major-tag
  if $set-major-tag {
    set major-tag = (major-tag:create $major $dry-run)
  } else {
    console:echo 💬 Skipping major tag, as requested
    set major-tag = $nil
  }

  put [
    &tag=$tag
    &major-tag=$major-tag
  ]
}