use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/git
use github.com/giancosta86/ethereal/v1/semver
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/gauntlet/v1/output
use github.com/giancosta86/gauntlet/v1/pull-request
use github.com/giancosta86/gauntlet/v1/release
use github.com/giancosta86/gauntlet/v1/repository

fn skip {
  echo '💭 tag-and-release can only run when merging a pull request...'

  env:set skip true
}

fn delete-branch-from-origin { |branch|
  console:inspect &emoji=🌴 'Deleting the merged branch' $branch

  try {
    git push origin --delete $branch
    echo ✅ Merged branch deleted!
  } catch {
    echo 💭 The branch could not be deleted - probably, it is already deleted...
  }
}

fn create-and-push-tag { |tag|
  echo 📤 Creating and pushing the tag to origin...

  git tag -f $tag

  git push origin $tag

  echo ✅ Tag pushed!
}

fn create-release-draft { |release-title tag|
  try {
    gh release delete --yes $tag

    console:inspect &emoji=🧹 'Existing release draft deleted for tag' $tag
  } catch {
  }

  console:inspect &emoji=📝 'Now creating release draft' $release-title

  release:create-draft $tag $release-title

  echo ✅ Release draft created!
}

fn update-major-branch { |major-branch tag|
  console:inspect &emoji=🌳 'Updating major version branch' $major-branch

  git:ensure-in-branch $major-branch

  git reset --hard $tag

  git push -f origin $major-branch

  echo ✅ Major version branch updated!
}

fn get-major-branch { |branch-version|
  if (> $branch-version[major] 0) {
    put 'v'$branch-version[major]
  } else {
    put 'v0.'$branch-version[minor]
  }
}

fn main {
  var product-name = (
    input:string &optional product-name |
      coalesce (all) (repository:get-name)
  )

  var update-major-branch = (input:bool update-major-branch)

  var branch = (pull-request:get-branch)
  console:inspect &emoji=🌲 'Merged branch' $branch

  var branch-version = (semver:parse $branch)
  console:inspect &emoji=🏷️ 'Branch version' $branch-version

  var version-string = (
    put $branch-version[major]'.'$branch-version[minor]'.'$branch-version[patch]
  )
  console:inspect &emoji=✒️ 'Version string' $version-string

  delete-branch-from-origin $branch

  var tag = 'v'$version-string
  console:inspect &emoji=📌 'Tag' $tag

  create-and-push-tag $tag

  var release-title = $product-name' '$version-string
  create-release-draft $release-title $tag

  var major-branch

  if $update-major-branch {
    set major-branch = (get-major-branch $branch-version)
    update-major-branch $major-branch $tag
  } else {
    set major-branch = ''
    echo 💭 Skipping the update of the major branch, as requested...
  }

  output:map [
    &tag=$tag
    &major-branch=$major-branch
  ]
}