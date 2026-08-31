use os
use path
use github.com/giancosta86/gauntlet/v1/env

echo 🎭 Setting up the tests...

var temp-project-dir = (os:temp-dir)

env:set temp-project-dir $temp-project-dir

{
  echo java=8.0.502.fx-zulu
  echo maven=3.3.9
  echo gradle=2.10
} > (path:join $temp-project-dir .sdkmanrc)