use github.com/giancosta86/gauntlet/v1/input
use ../jvm/build-tool

fn main {
  var quiet-tool = (input:bool quiet-tool)

  var build-tool-module: = (
    get-env jvm-build-tool |
      build-tool:get-module
  )

  build-tool-module:verify-project &quiet=$quiet-tool
}