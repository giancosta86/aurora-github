use os
use github.com/giancosta86/astral-bridge/package-manager
use ./input

fn main {
  var client-tests-directory = (input:string &optional $client-tests-directory)

  if $client-tests-directory {
    if (os:is-dir $client-tests-directory) {
      echo 💡 Client tests directory found!

      echo 🧭 Running the client tests...
      {
        tmp pwd = $client-tests-directory
        package-manager:exec test
      }

      echo ✅ Client tests run!
    } else {
      echo 💭 Client tests directory cannot be found
    }
  } else {
    echo 💭 No client tests directory specified...
  }
}