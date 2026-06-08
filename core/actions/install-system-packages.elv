use ../system-packages
use ./input

fn main {
  system-packages:install [
    &required-command=(input:string &optional required-command)

    &packages=(input:list packages)

    &initial-update=(input:bool initial-update)
  ]
}