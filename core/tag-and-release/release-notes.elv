use file
use re
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang
use github.com/giancosta86/aurora-elvish/seq
use ../ci-cd/repository

fn -write-commit-list { |pull-request|
  var base-sha = $pull-request[base-sha]
  var head-sha = $pull-request[head-sha]

  var marker = '§+-+§'

  var commit-list = (git log --no-merges --reverse --pretty=format:$marker'* %B' $base-sha'..'$head-sha |
    slurp |
    re:replace '(?m)^' '  ' (all) |
    str:replace '  '$marker '' (all) |
    str:trim-space (all)
  )

  echo $commit-list
}

fn -write-pull-request-data { |pull-request|
  var title = $pull-request[title]
  var number = $pull-request[number]

  echo '**Pull request**: '$title' (#'$number')'
}

fn -write-changelog-footer { |pull-request tag|
  var base-sha = $pull-request[base-sha]

  var most-specific-base-tag = (
    git tag --points-at $base-sha |
      order &key={ |tag| count $tag } &reverse |
      take 1 |
      lang:ensure-put
  )

  var base-reference

  if $most-specific-base-tag {
    console:echo 📌 Tag "'"$most-specific-base-tag"'" found for the "'"$base-sha"'" base SHA
    set base-reference = $most-specific-base-tag
  } else {
    console:echo 💭 No tags associated with the "'"$base-sha"'" base SHA - using it directly
    set base-reference = $base-sha
  }

  console:inspect &emoji=🧭 'Base reference' $base-reference
  console:inspect &emoji=📌 'Release tag' $tag

  echo '**Full changelog**: '(repository:get-changelog $base-reference $tag)
}

fn generate { |inputs|
  console:inspect-inputs $inputs

  var output-file = $inputs[output-file]
  var tag = $inputs[tag]
  var pull-request = $inputs[pull-request]

  {
    -write-commit-list $pull-request

    echo '---'

    -write-pull-request-data $pull-request

    -write-changelog-footer $pull-request $tag
  } >> $output-file

  file:close $output-file

  console:section &emoji=📝 'Generated release notes' {
    cat $output-file[name]
  }
}