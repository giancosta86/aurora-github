use github.com/giancosta86/aurora-elvish/console
use ../ci-cd/pull-request
use ../git

fn fetch { |pull-request|
  var branch = $pull-request[branch]
  var base-sha = $pull-request[base-sha]
  var head-sha = $pull-request[head-sha]

  if (pull-request:triggers-current-workflow) {
    console:echo 📥 Fetching Git log within a pull request workflow...

    git fetch origin $base-sha $head-sha
  } else {
    console:echo 📥 Fetching Git log not within a pull request workflow...

    git:fetch-branched-sha $branch $head-sha
    git:fetch-branched-sha $branch $base-sha
  }

  console:echo ✅ Git log ready!
}