use ../ci-cd/release-assets
use ./input

fn main {
  release-assets:publish [
    &release-tag=(input:string release-tag)

    &files=(input:list files)

    &overwrite=(input:bool overwrite)
  ]
}