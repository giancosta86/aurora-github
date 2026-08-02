#!/usr/bin/env elvish

#
# Script updating the inter-repository 'uses:' references
# between composite GitHub actions, so that only the current branch is referenced.
#
# Just run the script, with no arguments; also, the execution is idempotent.
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

src |
  put (all)[name]
  path:dir (all) |
  path:dir (all) |
  path:join (all) actions |
  put (all)/**.yml |
  each { |action-path|
    var content = (slurp < $action-path)

    re:replace $reference-regex '${1}'$git-branch content > $action-path
  }

echo ✅ All references updated!