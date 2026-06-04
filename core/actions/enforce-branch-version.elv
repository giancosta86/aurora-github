use ../branch-version
use ./input

fn main {
  var artifact-descriptor = (input:string &optional artifact-descriptor)

  var mode = (input:enum mode [inject check skip])

  branch-version:enforce &descriptor-name=$artifact-descriptor $mode
}