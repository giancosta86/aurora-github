use os
use github.com/giancosta86/aurora-elvish/command
use github.com/giancosta86/aurora-elvish/console

fn -should-run-installer { |required-command|
  if $required-command {
    console:inspect &emoji=📥 'Required command' $required-command

    if (command:exists-in-bash $required-command) {
      console:echo ✅ Required command available - no need to install it!
      put $false
      return
    } else {
      console:echo 💬 Required command not available - now installing its packages...
    }
  } else {
    console:echo 💫 No required command passed - the requested packages will be installed unconditionally...
  }

  put $true
}

fn -run-initial-update {
  var flag-file = ~/.install-system-packages-updated

  if (os:is-regular $flag-file) {
    console:echo 💡 The package list has already been updated!
    return
  }

  console:echo 📥 Updating the package list...

  command:silence-until-error {
    sudo apt-get update
  }

  touch $flag-file
}

fn -run-installer { |requested-packages|
  console:echo 📦 Installing packages...

  command:silence-until-error {
    sudo apt-get install -y $@requested-packages
  }

  console:echo ✅ Packages installed!
}

fn install { |inputs|
  console:inspect-inputs $inputs

  var packages = $inputs[packages]
  var required-command = $inputs[required-command]
  var initial-update = $inputs[initial-update]

  if (not (-should-run-installer $required-command)) {
    return
  }

  if $initial-update {
    -run-initial-update
  }

  -run-installer $packages
}
