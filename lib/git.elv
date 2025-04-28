use ./lang
use ./console
use ./command

fn hard-reset {
  echo ⏱️Discarding local changes to the Git repository...
  git reset --hard HEAD
  echo ✅Git repository successfully reset
}

fn fetch-branched-sha { |branch required-sha|
  var depth-delta = 25

  console:inspect &emoji=🧭 'Ensuring Git SHA' $required-sha

  while (not ?(git cat-file commit $required-sha > /dev/null 2>&1)) {
    echo 📥Fetching $depth-delta more commits...

    git fetch --deepen=$depth-delta origin $branch

    set depth-delta = (* $depth-delta 2)
  }

  console:inspect &emoji=✅ 'Git SHA ready' $required-sha
}

fn fetch-tags {
  echo 📥Retrieving Git tags...

  command:show-log-on-error 'git fetch --tags'

  echo ✅Git tags retrieved!
}

fn create-push-tag { |tag &force=$false|
  console:inspect &emoji=📌 'Creating and pushing Git tag' $tag

  var force-arg = (core:ternary $force [--force] [])

  git tag $@force-arg $tag
  git push origin $tag $@force-arg

  echo 📌Tag created and pushed!
}