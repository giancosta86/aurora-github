use os
use path
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/script
use ../ci-cd/repository
use ./release-notes

fn -get-release-title { |version|
  var repository-full-name = (repository:get-full-name)

  var repository-basename = (path:base $repository-full-name)
  console:inspect &emoji=🧭 'Repository basename' $repository-basename

  put $repository-basename' '$version
}

fn create { |inputs|
  console:inspect-inputs $inputs

  var tag = $inputs[tag]
  var version = $inputs[version]
  var dry-run = $inputs[dry-run]
  var draft-release = $inputs[draft-release]
  var notes-file-processor = $inputs[notes-file-processor]
  var pull-request = $inputs[pull-request]

  var release-title = (-get-release-title $version)
  console:inspect &emoji=🔎 'Release title' $release-title

  var release-notes-file = (os:temp-file)
  defer {
    os:remove $release-notes-file[name]
  }

  release-notes:generate [
    &output-file=$release-notes-file
    &tag=$tag
    &pull-request=$pull-request
  ]

  if $notes-file-processor {
    console:inspect &emoji=🖋 'Release notes file processor' $notes-file-processor

    script:run $notes-file-processor $release-notes-file[name]

    console:section &emoji=🎀 'Processed release notes' {
      cat $release-notes-file[name]
    }
  } else {
    console:echo 💭 No release notes file processor...
  }

  if $draft-release {
    console:inspect &emoji=📝 'Drafting release' $release-title

    if (not $dry-run) {
      gh release create $tag --title $release-title --latest --notes-file $release-notes-file[name] --draft

      console:echo 📝 Release drafted!
    } else {
      console:echo 💭 Just simulating draft release creation, in dry-run mode...
    }
  } else {
    console:inspect &emoji=🌟 'Publishing release' $release-title

    if (not $dry-run) {
      gh release create $tag --title $release-title --latest --notes-file $release-notes-file[name]

      console:echo 🌟 Release published!
    } else {
      console:echo 💭 Just simulating release publication, in dry-run mode...
    }
  }
}