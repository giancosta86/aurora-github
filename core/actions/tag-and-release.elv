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
}