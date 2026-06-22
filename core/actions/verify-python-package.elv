use ../python/context
use ../python/project
use ./input

fn main {
  var pdm-version = (input:string &optional pdm-version)

  context:setup &pdm-version=$pdm-version

  project:verify

  project:build
}