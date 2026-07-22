use os
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/gauntlet/v1/env

var tag = test-release

fn clean-previous-runs {
  env:set tag $tag

  echo 🧹 Preventively deleting the $tag release and its tag, if existing...

  all [
    { gh release delete --cleanup-tag --yes $tag }
    { git tag --delete $tag }
    { git push origin --delete $tag }
  ] |
    each { |block| command:silence &on-exception=none $block }

  echo ✅ Pre-existing tag and release should not exist now!
}

fn create-test-release {
  echo 📝 Now creating a $tag tag just for these tests...
  git tag -f $tag
  git push origin $tag
  echo ✅ Test tag created!

  echo 📝 Now creating a $tag draft release just for these tests...
  gh release create $tag --draft --title 'Test release' --notes 'This volatile release is only used by the tests!'
  echo ✅ Test release created!
}

fn main {
  echo 🎭 Initializing the test environment...

  clean-previous-runs

  create-test-release

  echo ✅ Test environment ready!
}