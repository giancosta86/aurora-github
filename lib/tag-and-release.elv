use path
use os
use file
use ./github/pull-request
use ./tag-and-release/git-log
use ./tag-and-release/release-notes
use ./branch-version/detection
use ./git
use ./script
use ./console
use ./seq
use ./output

fn -assert-not-triggered-by-pull-request {
  var triggered-by-pull-request = (pull-request:triggers-current-workflow)
  console:inspect 'Triggered by pull request' $triggered-by-pull-request

  if $triggered-by-pull-request {
    fail 'This action can be run from a workflow triggered by a pull-request only when dry-run is enabled'
  }
}

fn -create-release { |inputs|
  console:inspect-inputs $inputs

  var tag = $inputs[tag]
  var version = $inputs[version]
  var dry-run = $inputs[dry-run]
  var draft-release = $inputs[draft-release]
  var notes-file-processor = $inputs[notes-file-processor]
  var github-repository = $inputs[github-repository]
  var repo-basename = $inputs[repo-basename]
  var pull-request = $inputs[pull-request]

  var release-title = $repo-basename' '$version
  console:inspect &emoji=🔎 'Release title' $release-title

  var release-notes-file = (os:temp-file)
  defer {
    os:remove $release-notes-file[name]
  }

  release-notes:generate [
    &output-file=$release-notes-file
    &tag=$tag
    &pull-request=$pull-request
    &github-repository=$github-repository
  ]

  if $notes-file-processor {
    console:inspect &emoji=🖋 'Release notes file processor found' $notes-file-processor

    script:run $notes-file-processor $release-notes-file[name]

    console:section &emoji=🎀 'Processed release notes' {
      cat $release-notes-file[name]
    }
  } else {
    echo 💭No release notes file processor...
  }

  if $draft-release {
    console:inspect &emoji=📝 'Drafting release' $release-title

    if (not $dry-run) {
      gh release create $tag --title $release-title --latest --notes-file $release-notes-file[name] --draft

      echo 📝Release drafted!
    } else {
      echo 💭Just simulating draft release creation, in dry-run mode...
    }
  } else {
    console:inspect &emoji=🌟 'Publishing release' $release-title

    if (not $dry-run) {
      gh release create $tag --title $release-title --latest --notes-file $release-notes-file[name]

      echo 🌟Release published!
    } else {
      echo 💭Just simulating release creation, in dry-run mode...
    }
  }
}

fn -create-major-tag { |major dry-run|
  var major-tag = v$major

  console:inspect &emoji=🪩 'Setting major version tag' $major-tag

  if (not $dry-run) {
    git:create-push-tag &force $major-tag

    echo 🪩Major version tag set!
  } else {
    echo 💭Just simulating major version tag creation, in dry-run mode...
  }

  output:write major-tag $major-tag
}

fn run-action { |inputs|
  console:inspect-inputs $inputs

  var dry-run = $inputs[dry-run]
  var git-strategy = $inputs[git-strategy]
  var set-major-tag = $inputs[set-major-tag]
  var github-repository = $inputs[github-repository]

  var repo-basename = (path:base $github-repository)
  console:inspect &emoji=🧭 'Repository basename' $repo-basename

  var version-info = (detection:detect)
  var version = $version-info[version]
  var branch = $version-info[branch]
  var major = $version-info[major]

  if (not $dry-run) {
    -assert-not-triggered-by-pull-request
  }

  var pull-request = (pull-request:fetch-info $branch)
  console:inspect &emoji=🔁 'Pull request' $pull-request

  git:hard-reset

  git-log:fetch $pull-request

  git:fetch-tags

  if (not $dry-run) {
    pull-request:merge $branch $git-strategy
  } else {
    echo 💭Just simulating pull request merging, in dry-run mode...
  }

  var tag = v$version
  console:inspect &emoji=📌 'Tag to create' $tag
  output:write tag $tag

  if (not $dry-run) {
    git:create-push-tag $tag
  } else {
    echo 💭Just simulating Git tag creation, in dry-run mode...
  }

  -create-release [
    &tag=$tag
    &version=$version
    &dry-run=$dry-run
    &draft-release=$inputs[draft-release]
    &notes-file-processor=$inputs[notes-file-processor]
    &github-repository=$github-repository
    &repo-basename=$repo-basename
    &pull-request=$pull-request
  ]

  if $set-major-tag {
    -create-major-tag $major $dry-run
  } else {
    echo 💬Skipping major tag, as requested
  }
}