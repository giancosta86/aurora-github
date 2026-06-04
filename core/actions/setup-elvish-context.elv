use epm
use os
use path

fn link-aurora-github-core {
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
