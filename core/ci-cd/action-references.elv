use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/seq
use ./repository

fn get-regex-for-references-to-other-branches { |current-branch|
  var full-repository-name = (repository:get-full-name)

  put 'uses:\s*'$full-repository-name'[^@]+@(?!'$current-branch')'
}