use os
use github.com/giancosta86/gauntlet/v1/env

echo 🎭 Setting up the tests...

os:temp-dir |
  env:set temp-project-dir (all)