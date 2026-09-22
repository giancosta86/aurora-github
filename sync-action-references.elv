#!/usr/bin/env elvish

#
# Script updating the intra-repository 'uses:' references
# between composite GitHub actions, so that only the current branch is referenced.
#
# The script also updates the example usages in README files.
#
# Just run the script, with no arguments, from any directory; also, the execution is idempotent.
#

use path
use re
use str

var reference-regex = '(-?\s+uses:\s+giancosta86/aurora-github/actions/[^@]+@)\S+'

var git-branch = (
  git status |
    take 1 |
    put (all)[10..]
)
echo 🌲 Current Git branch: $git-branch

var version-tag = (
  if (str:has-prefix $git-branch v) {
    put $git-branch
  } else {
    put 'v'$git-branch
  }
)
echo 🏷️ Version tag: $version-tag

var actions-directory = (
  src |
    put (all)[name] |
    path:dir (all) |
    path:join (all) actions
)
echo 📁 Actions directory: $actions-directory

fn create-reference-updater { |&major-only=$false emoji|
  put { |source-path|
    put $source-path[(+ (count $actions-directory) 1)..] |
      echo $emoji (all)

    var updated-reference = (
      if $major-only {
        put $version-tag |
          str:split . (all) |
          take 1
      } else {
        put $version-tag
      }
    )

    var updated-content = (
      slurp < $source-path |
        re:replace $reference-regex '${1}'$updated-reference (all)
    )

    print $updated-content > $source-path
  }
}

fn update-actions {
  var action-updater = (create-reference-updater 📜)

  put $actions-directory/**.yml |
    each $action-updater
}


fn update-readmes {
  var readme-updater = (create-reference-updater &major-only 🗒️)

  put $actions-directory/**/README.md |
    each $readme-updater
}


fn main {
  update-actions

  update-readmes

  echo ✅ All references updated!
}

main