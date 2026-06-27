use math
use github.com/giancosta86/aurora-elvish/command
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang

fn ensure-in-branch { |branch|
  try {
    git switch -c $branch
  } catch {
    git switch $branch
  }
}

fn hard-reset {
  console:echo ⏱️ Discarding local changes to the Git repository...

  command:silence {
    git reset --hard HEAD
  }

  console:echo ✅ Git repository successfully reset
}

fn fetch-branched-sha { |&depth-delta=25 &delta-factor=1.5 branch required-sha|
  console:inspect &emoji=🧭 'Iteratively trying to fetch Git SHA' $required-sha

  while (not ?(command:silence { git cat-file commit $required-sha })) {
    console:echo 📥 Fetching $depth-delta more commits...

    command:silence {
      git fetch --deepen=$depth-delta origin $branch
    }

    set depth-delta = (* $depth-delta $delta-factor | math:ceil (all) | exact-num (all))
  }

  console:inspect &emoji=✅ 'Git SHA ready' $required-sha
}

fn fetch-tags {
  console:echo 📥 Retrieving Git tags...

  command:silence {
    git fetch --tags
  }

  console:echo ✅ Git tags retrieved!
}

fn create-and-push-tag { |&force=$false tag|
  console:inspect &emoji=📌 'Creating and pushing Git tag' $tag

  var force-arg = (lang:ternary $force [--force] [])

  command:silence {
    git tag $@force-arg $tag
    git push origin $tag $@force-arg
  }

  console:echo 📌 Tag created and pushed!
}