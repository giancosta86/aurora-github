use str
use file
use re
use str
use ../seq
use ../console

fn -write-commit-list { |pull-request|
  var marker = '§+-+§'

  var commit-list = (git log --no-merges --reverse --pretty=format:$marker'* %B' $pull-request[base-sha]'..'$pull-request[head-sha] |
    slurp |
    re:replace '(?m)^' '  ' (all) |
    str:replace '  '$marker '' (all) |
    str:trim-space (all)
  )

  echo $commit-list
}

fn -write-pull-request-data { |pull-request|
  print '**Pull request**: '$pull-request[title]' (#'$pull-request[number]'):"'
}

fn -write-changelog-footer { |inputs|
  console:inspect-inputs $inputs

  var pull-request = $inputs[pull-request]
  var tag = $inputs[tag]
  var github-repository = $inputs[github-repository]

  var most-specific-base-tag = (git tag --points-at $pull-request[base-sha] | awk '{ print length, $0 }' | sort -nr | cut -d' ' -f2- | head -n 1)

  var base-reference
  if (seq:is-non-empty $most-specific-base-tag) {
    console:echo 📌Tag "'"$most-specific-base-tag"'" found for the "'"$pull-request[base-sha]"'" base SHA
    set base-reference = $most-specific-base-tag
  } else {
    console:echo 💭No tags associated with the "'"$pull-request[base-sha]"'" base SHA - using it directly
    set base-reference = $pull-request[base-sha]
  }

  console:inspect &emoji=🧭 'Base reference' $base-reference
  console:inspect &emoji=📌 'Release tag' $tag

  echo '**Full changelog**: https://github.com/'$github-repository'/compare/'$base-reference'..'$tag
}

fn generate { |inputs|
  console:inspect-inputs $inputs

  var output-file = $inputs[output-file]
  var tag = $inputs[tag]
  var pull-request = $inputs[pull-request]
  var github-repository = $inputs[github-repository]

  -write-commit-list $pull-request >> $output-file

  echo '---' >> $output-file

  -write-pull-request-data $pull-request >> $output-file

  echo >> $output-file

  -write-changelog-footer [
    &pull-request=$pull-request
    &tag=$tag
    &github-repository=$github-repository
  ] >> $output-file

  file:close $output-file

  console:section &emoji=📝 'Release notes generated' {
    cat $output-file[name]
  }
}