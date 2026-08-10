use os
use github.com/giancosta86/astral-bridge/v1/package-manager
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/gauntlet/v1/env

fn check-preconditions {
  var client-tests-directory = (input:string &optional client-tests-directory)

  if (and $client-tests-directory (os:is-dir $client-tests-directory)) {
    echo 💡 Client tests directory found! >&2
    put $true
  } else {
    echo 💭 No client tests directory specified... >&2
    put $false
  } |
    env:set run-client-tests (all)
}

fn main {
  var client-tests-directory = (input:string client-tests-directory)

  tmp pwd = $client-tests-directory

  echo 🧭 Running the client tests...
  package-manager:exec test
  echo ✅ Client tests OK!
}