use epm
use os
use path

fn create-link-to-core {
  var action-path = (get-env GITHUB_ACTION_PATH)

  var link-path = (
    path:join $epm:managed-dir github.com giancosta86 aurora-github
  )

  if (not (os:exists $link-path)) {
    path:dir $link-path |
      os:mkdir-all (all)

    var aurora-github-core-directory = (
      path:join $action-path .. .. core
    )

    os:symlink $aurora-github-core-directory $link-path
  }
}

fn print-elvish-version {
  use github.com/giancosta86/aurora-github/std-err

  std-err:section &emoji=🔮 'Elvish version' {
    elvish --version
  }
}

fn try-to-install-ethereal {
  use github.com/giancosta86/aurora-github/input

  var ethereal-version = (input:string &optional ethereal-version)

  if $ethereal-version {
    use github.com/giancosta86/aurora-github/epm-plus
    epm-plus:install 'github.com/giancosta86/ethereal@'$ethereal-version
  }
}

fn main {
  create-link-to-core

  print-elvish-version

  try-to-install-ethereal
}