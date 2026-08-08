use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/gauntlet/v1/release

fn main {
  var overwrite = (input:bool overwrite)

  var release-tag = (input:string release-tag)

  var files = (input:list files)

  release:upload-artifacts &overwrite=$overwrite $release-tag $@files
}