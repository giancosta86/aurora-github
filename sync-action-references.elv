#!/usr/bin/env elvish

#
# Script updating the intra-repository 'uses:' references
# between composite GitHub actions, so that only the current branch is referenced.
#
# Just run the script, with no arguments, from any directory; also, the execution is idempotent.
#

use path
use re
use str

var reference-regex = '(-\s+uses:\s+giancosta86/aurora-github/actions/[^@]+@)\S+'

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
    path:dir (all) |
    path:join (all) actions
)
echo 📁 Actions directory: $actions-directory

put $actions-directory/**.yml |
  each { |action-path|
    put $action-path[(+ (count $actions-directory) 1)..] |
      echo 📜 (all)

    var updated-content = (
      slurp < $action-path |
        re:replace $reference-regex '${1}'$version-tag (all)
    )

    print $updated-content > $action-path
  }

echo ✅ All references updated!