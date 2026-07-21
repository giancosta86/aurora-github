use github.com/giancosta86/gauntlet/v1/release
use ./input

fn main {
  release:upload-assets [
    &release-tag=(input:string release-tag)

    &files=(input:list files)

    &overwrite=(input:bool overwrite)
  ]
}