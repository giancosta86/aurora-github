use os
use ./ci-cd/env
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/script
use github.com/giancosta86/aurora-elvish/testing

fn -set-strategy { |strategy|
  console:inspect &emoji=💡 'Current test strategy' $strategy
  env:write strategy $strategy
}

fn -set-script-strategy { |script-path|
  -set-strategy script

  console:inspect &emoji=📃 'Test script to run' $script-path

  env:write scriptPath $script-path
}

fn -enforce-exit-strategy {
  -set-strategy exit
}

fn detect-strategy { |inputs|
  console:inspect-inputs $inputs

  var optional = $inputs[optional]
  var script-file = $inputs[script-file]
  var root-directory = $inputs[root-directory]

  console:echo 🔬 Looking for a custom test strategy...

  if (not $root-directory) {
    if $optional {
      console:echo 💭 Skipping optional tests in missing root directory...
      -enforce-exit-strategy
      return
    } else {
      fail "Cannot run custom tests in missing root directory: '"$root-directory"'!"
    }
  }

  console:echo 🔁📁 Test root directory "'"$root-directory"'" found!
  tmp pwd = $root-directory

  var target-script-file = (coalesce $script-file verify)

  var actual-script-path = (script:get-actual-path $target-script-file)

  if $actual-script-path {
    console:echo 🐚 Shell script strategy requested!
    -set-script-strategy $actual-script-path
    return
  } else {
    if $script-file {
      var error-message = "Cannot find the '"$script-file"' script file"

      if $optional {
        console:echo 💭 $error-message...
        -enforce-exit-strategy
        return
      } else {
        fail $error-message
      }
    }
  }

  if (testing:has-tests) {
    console:echo 📋 aurora-elvish .test.elv files found!
    -set-strategy test-runner
    return
  }

  if (os:is-regular package.json) {
    console:echo 📦 package.json file found!
    -set-strategy nodejs
    return
  }

  if (os:is-regular Cargo.toml) {
    console:echo 🦀 Cargo.toml file found!
    -set-strategy rust
    return
  }

  if $optional {
    console:echo 💭 No supported strategy detected for the optional custom tests...
    -enforce-exit-strategy
  } else {
    fail 'Cannot run mandatory custom tests: no supported test strategy could be detected!'
  }
}

fn execute-test-runner {
  var testing-result = (testing:run)

  if $testing-result[is-ok] {
    console:echo ✅ All the $testing-result[total-tests] tests are OK!
  } else {
    console:block &emoji=❌ $testing-result[total-failed]' tests failed' {
      pprint $testing-result
    }

    exit 1
  }
}