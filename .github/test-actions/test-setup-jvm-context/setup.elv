use os
use path
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env

echo 🎭 Setting up the tests...

var temp-project-dir = (os:temp-dir)

path:join $temp-project-dir $sdkman:sdk-file |
  cp $sdkman:sdk-file (all)

env:set temp-project-dir $temp-project-dir