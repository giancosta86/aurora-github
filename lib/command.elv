use os
use ./console

fn show-log-on-error { |command-line|
  var output-file = (os:temp-file)

  try {
    var command-outcome = ?(elvish -c $command-line' > "'$output-file[name]'" 2>&1')

    if (not $command-outcome) {
      if (os:is-regular $output-file[name]) {
        console:section &emoji=❌ 'Error while running the command! Log' {
          cat < $output-file
        }
      } else {
        console:display &emoji=💭 Cannot find the log file...
      }

      fail $command-outcome
    }
  } finally {
    rm -f $output-file
  }
}


