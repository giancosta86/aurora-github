use ./repository

fn get-regex-for-references-to-other-branches { |current-branch|
  var full-repository-name = (repository:get-full-name)

  put 'uses:\s*'$full-repository-name'[^@]+@(?!'$current-branch')'
}