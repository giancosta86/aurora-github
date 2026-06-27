use ../ci-cd/release
use ./input

fn main {
  release:publish-assets [
    &release-tag=(input:string release-tag)

    &files=(input:list files)

    &overwrite=(input:bool overwrite)
  ]
}