#!/usr/bin/env elvish

#
# Script updating the inter-repository 'uses:' references
# between composite GitHub actions, so that only the current branch is referenced.
#
# Just run the script, with no arguments, from any directory; also, the execution is idempotent.
#

use path
use re

var reference-regex = '(-\s+uses:\s+giancosta86/aurora-github/actions/[^@]+@)\S+'

var git-branch = (
  git status |
    take 1 |
    put (all)[10..]
)
echo 🌲 Current Git branch: $git-branch

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

    var content = (slurp < $action-path)

    re:replace $reference-regex '${1}'$git-branch content > $action-path
  }

echo ✅ All references updated!