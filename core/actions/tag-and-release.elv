use github.com/giancosta86/ethereal/v1/semver
use ../ci-cd/pull-request
use ../ci-cd/repository
use ../git
use ../std-err
use ./input

fn main {
  var draft = (input:bool draft)

  var main-branch = (input:string main-branch)

  var product-name = (
    input:string &optional product-name |
      coalesce (all) (repository:get-name)
  )

  var update-major-branch = (input:bool update-major-branch)

  std-err:inspect &emoji=📥 Inputs [
    &draft=$draft
    &product-name=$product-name
    &update-major-branch=$update-major-branch
  ]

  var branch = (pull-request:get-branch)
  std-err:inspect &emoji=🌲 'Branch' $branch

  var branch-version = (semver:parse $branch)
  std-err:inspect &emoji=🏷️ 'Branch version' $branch-version

  echo 🌴 Deleting the remote branch...
  git push origin --delete $branch
  echo ✅ Remote branch deleted!

  var version-string = $branch-version[major]'.'$branch-version[minor]'.'$branch-version[patch]
  std-err:inspect &emoji=📦 'Version string' $version-string

  var tag = 'v'$version-string
  std-err:inspect &emoji=📌 'Tag' $tag

  git tag $tag

  git push origin $tag

  var release-name = $product-name' '$version-string
  std-err:inspect &emoji=✏️ 'Release name' $release-name

  gh release create $tag --draft --title $release-name --notes ''

  if $update-major-branch {
    var major-branch = 'v'$branch-version[major]

    std-err:inspect &emoji=🌳 'Updating major version branch' $major-branch

    git:ensure-in-branch $major-branch

    git merge $main-branch

    git push origin $major-branch

    echo ✅ Major version branch updated!
  }
}