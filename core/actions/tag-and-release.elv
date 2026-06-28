use github.com/giancosta86/ethereal/v1/semver
use ../ci-cd/output
use ../ci-cd/pull-request
use ../ci-cd/release
use ../ci-cd/repository
use ../git
use ../console
use ./input

fn delete-branch-from-origin { |branch|
  console:inspect &emoji=🌴 'Deleting the merged branch' $branch

  git push origin --delete $branch

  echo ✅ Merged branch deleted!
}

fn create-and-push-tag { |tag|
  echo 📤 Creating and pushing the tag to origin...

  git tag $tag

  git push origin $tag

  echo ✅ Tag pushed!
}

fn create-release-draft { |product-name version-string tag|
  var release-title = $product-name' '$version-string

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

  create-release-draft $product-name $version-string $tag

  var major-branch

  if $update-major-branch {
    set major-branch = 'v'$branch-version[major]

    update-major-branch $major-branch $tag
  } else {
    set major-branch = ''
  }

  output:map [
    &tag=$tag
    &major-branch=$major-branch
  ]
}