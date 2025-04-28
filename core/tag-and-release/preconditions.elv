use github.com/giancosta86/aurora-elvish/console
use ../ci-cd/pull-request

fn -check-trigger { |dry-run|
  var triggered-by-pull-request = (pull-request:triggers-current-workflow)
  console:inspect 'Triggered by pull request' $triggered-by-pull-request

  if $triggered-by-pull-request {
    if $dry-run {
      console:echo ⛵ Since dry-run is enabled, the action can be run in a pull-request-triggered workflow
    } else {
      fail 'This action can be run from a workflow triggered by a pull-request only when dry-run is enabled'
    }
  }
}

fn check { |dry-run|
  -check-trigger $dry-run
}
