use github.com/giancosta86/ethereal/v1/semver
use ../ci-cd/pull-request
use ../ci-cd/release
use ../ci-cd/repository
use ../git
use ../console
use ./input

fn main {
  var product-name = (
    input:string &optional product-name |
      coalesce (all) (repository:get-name)
  )

  var update-major-branch = (input:bool update-major-branch)

  var branch = (pull-request:get-branch)
  console:inspect &emoji=🌲 'Branch' $branch

  var branch-version = (semver:parse $branch)
  console:inspect &emoji=🏷️ 'Branch version' $branch-version

  echo 🌴 Deleting the remote branch...
  git push origin --delete $branch
  echo ✅ Remote branch deleted!

  var version-string = $branch-version[major]'.'$branch-version[minor]'.'$branch-version[patch]
  console:inspect &emoji=📦 'Version string' $version-string

  var tag = 'v'$version-string
  console:inspect &emoji=📌 'Tag' $tag

  echo 📤 Creating and pushing the tag to origin...
  git tag $tag
  git push origin $tag
  echo ✅ Tag pushed!

  var release-title = $product-name' '$version-string

  console:inspect &emoji=📝 'Now creating release draft' $release-title
  release:create-draft $tag $release-title
  echo ✅ Release draft created!

  if $update-major-branch {
    var major-branch = 'v'$branch-version[major]

    console:inspect &emoji=🌳 'Updating major version branch' $major-branch

    git:ensure-in-branch $major-branch

    git merge $tag

    git push origin $major-branch

    echo ✅ Major version branch updated!
  }
}