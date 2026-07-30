use os
use github.com/giancosta86/astral-bridge/v1/package-manager
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/ethereal/v1/command

fn main {
  var client-tests-directory = (input:string &optional client-tests-directory)

  if $client-tests-directory {
    if (os:is-dir $client-tests-directory) {
      echo 💡 Client tests directory found!

      tmp pwd = $client-tests-directory

      echo 📥 Installing client tests dependencies...
      command:silence {
        package-manager:exec install
      }
      echo 🚀 Client test dependencies ready!

      echo 🧭 Running the client tests...
      package-manager:exec test
      echo ✅ Client tests OK!
    } else {
      echo 💭 Client tests directory not found...
    }
  } else {
    echo 💭 No client tests directory specified...
  }
}