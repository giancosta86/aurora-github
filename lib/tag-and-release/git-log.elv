use ../github/pull-request
use ../git

fn fetch { |pull-request|
  if (pull-request:triggers-current-workflow) {
    echo 📥Fetching Git log within a pull request workflow...

    git fetch origin $pull-request[base-sha] $pull-request[head-sha]
  } else {
    echo 📥Fetching Git log not within a pull request workflow...

    git:fetch-branched-sha $pull-request[branch] $pull-request[head-sha]
    git:fetch-branched-sha $pull-request[branch] $pull-request[base-sha]
  }

  echo ✅Git log ready!
}