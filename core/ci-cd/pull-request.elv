use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang

fn triggers-current-workflow {
  var github-ref = (get-env GITHUB_REF)
  console:inspect &emoji=🧭 'GITHUB_REF' $github-ref

  lang:ternary (str:has-prefix $github-ref 'refs/pull/') $true $false
}

fn fetch-info { |branch|
  console:inspect &emoji=😺 'Retrieving Git pull request info for branch' $branch

  var raw-data = (gh pr view $branch --json title,number,baseRefOid,headRefOid | from-json)

  put [
    &branch=$branch
    &title=$raw-data[title]
    &number=$raw-data[number]
    &base-sha=$raw-data[baseRefOid]
    &head-sha=$raw-data[headRefOid]
  ]
}

fn merge { |branch git-strategy|
  console:inspect &emoji=🔀 'Now merging the PR for branch' $branch
  console:inspect &emoji=💡 'Git strategy' $git-strategy

  var git-stategy-arg = '--'$git-strategy

  gh pr merge $branch $git-stategy-arg --delete-branch
}