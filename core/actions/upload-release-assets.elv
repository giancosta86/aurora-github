use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/gauntlet/v1/release

fn main {
  release:upload-artifacts [
    &release-tag=(input:string release-tag)

    &files=(input:list files)

    &overwrite=(input:bool overwrite)
  ]
}