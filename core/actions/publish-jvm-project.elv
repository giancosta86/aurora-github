use github.com/giancosta86/gauntlet/v1/input

fn main {
  var quiet-tool = (input:bool quiet-tool)
  var dry-run = (input:bool dry-run)

  var publisher-module = (
    get-env jvm-build-tool |
      build-tool:get-module
  )

  publisher-module:publish-project &quiet=$quiet-tool &dry-run=$dry-run
}