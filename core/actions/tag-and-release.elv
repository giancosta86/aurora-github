use github.com/giancosta86/ethereal/v1/semver
use ../ci-cd/pull-request
use ../ci-cd/repository
use ../std-err
use ./input

fn main {
  var draft = (input:bool draft)

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

  #TODO! Here, check the event, which MUST be a pull request merging

  var branch = (pull-request:get-branch)
  std-err:inspect &emoji=🌲 'Branch' $branch

  var branch-version = (semver:parse $branch)
  std-err:inspect &emoji=🏷️ 'Branch version' $branch-version

  #gh release create $tag --draft --title 'Test release' --notes 'This volatile release is only used by the tests!'
}