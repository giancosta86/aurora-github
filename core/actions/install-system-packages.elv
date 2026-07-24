use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/seq
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input

fn should-run-installer { |required-command|
  if $required-command {
    console:inspect &emoji=📥 'Required command' $required-command >&2

    if (command:exists-in-bash $required-command) {
      echo ✅ Required command available - no need to install it! >&2
      put $false
    } else {
      echo 💬 Required command not available - now installing its packages... >&2
      put $true
    }
  } else {
    echo 💫 No required command passed - the requested packages will be installed unconditionally... >&2
    put $true
  }
}

fn try-to-run-initial-update {
  var flag-variable = aurora-github-install-system-packages-initial-update-done

  var installer-already-run = (
    and (has-env $flag-variable) (eq (get-env $flag-variable) true)
  )

  if $installer-already-run {
    echo 💡 The package list has already been updated!
    return
  }

  echo 📥 Updating the package list...

  command:silence {
    sudo apt-get update
  }

  env:set $flag-variable true
}

fn run-installer { |requested-packages|
  echo 📦 Installing packages...

  command:silence {
    sudo apt-get install -y $@requested-packages
  }

  echo ✅ Packages installed!
}

fn main {
  var packages = (input:list packages)

  if (seq:is-empty $packages) {
    echo 💭 No packages requested...
    return
  }

  var required-command = (input:string &optional required-command)

  var initial-update = (input:bool initial-update)

  if (not (should-run-installer $required-command)) {
    return
  }

  if $initial-update {
    try-to-run-initial-update
  }

  run-installer $packages
}
