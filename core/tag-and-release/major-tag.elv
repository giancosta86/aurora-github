use github.com/giancosta86/aurora-elvish/console
use ../git

fn create { |major dry-run|
  var major-tag = v$major

  console:inspect &emoji=🪩 'Setting major version tag' $major-tag

  if (not $dry-run) {
    git:create-and-push-tag &force $major-tag

    console:echo 🪩 Major version tag set!
  } else {
    console:echo 💭 Just simulating major version tag creation, in dry-run mode...
  }

  put $major-tag
}