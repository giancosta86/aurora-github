use os
use str
use ./seq
use ./console
use ./env

var -default-script-files = [verify.elv verify.sh]

fn -set-strategy { |strategy|
  console:inspect &emoji=💡 'Current test strategy' $strategy
  env:write strategy $strategy
}

fn -set-script-strategy { |script-file|
  -set-strategy script
  console:inspect &emoji=📃 'Script file to run' $script-file
  env:write scriptFile $script-file
}

fn -enforce-exit-strategy {
  -set-strategy exit
}

fn detect-strategy { |inputs|
  console:inspect-inputs $inputs

  var root-directory = $inputs[root-directory]
  var script-file = $inputs[script-file]
  var optional = $inputs[optional]

  echo 🔬Looking for a custom test strategy...

  if (not (os:is-dir $root-directory)) {
    if $optional {
      echo 💭Skipping optional tests in missing root directory...
      -enforce-exit-strategy
      return
    } else {
      fail "Cannot run custom tests in missing root directory: '"$root-directory"'!"
    }
  }

  echo 🔁📁Test root directory "'"$root-directory"'" found!
  tmp pwd = $root-directory

  if $script-file {
    if (os:is-regular $script-file) {
      echo 🐚Custom script found!
      -set-script-strategy $script-file
      return
    } else {
      if $optional {
        console:inspect &emoji=💬 'The declared but optional script file is missing' $script-file
        -enforce-exit-strategy
        return
      } else {
        fail "Cannot run the declared mandatory script file: '"$script-file"'!"
      }
    }
  }

  for default-script-file $-default-script-files {
    if (os:is-regular $default-script-file) {
      echo 🐚Default script found!
      -set-script-strategy $default-script-file
      return
    }
  }

  if (os:is-regular package.json) {
    echo 📦package.json file found!
    -set-strategy nodejs
    return
  }

  if (os:is-regular Cargo.toml) {
    echo 🦀Cargo.toml file found!
    -set-strategy rust
    return
  }

  if $optional {
    echo 💭No supported strategy detected for the optional custom tests...
    -enforce-exit-strategy
  } else {
    fail 'Cannot run mandatory custom tests: no supported test strategy could be detected!'
  }
}