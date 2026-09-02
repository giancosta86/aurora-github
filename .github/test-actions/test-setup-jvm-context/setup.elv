use os
use path
use github.com/giancosta86/ethereal/v1/sdkman
use github.com/giancosta86/gauntlet/v1/env

echo 🎭 Setting up the tests...

var temp-project-dir = (os:temp-dir)

env:set temp-project-dir $temp-project-dir

cp .sdkmanrc $temp-project-dir