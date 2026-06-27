use os
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/fs
use ./console

fn -should-run-installer { |required-command|
  if $required-command {
    console:inspect &emoji=📥 'Required command' $required-command

    if (command:exists-in-bash $required-command) {
      echo ✅ Required command available - no need to install it!
      put $false
    } else {
      echo 💬 Required command not available - now installing its packages...
      put $true
    }
  } else {
    echo 💫 No required command passed - the requested packages will be installed unconditionally...
    put $true
  }
}

fn -run-initial-update {
  var flag-file = ~/.install-system-packages-updated

  if (os:is-regular $flag-file) {
    echo 💡 The package list has already been updated!
    return
  }

  echo 📥 Updating the package list...

  command:silence {
    sudo apt-get update
  }

  fs:touch $flag-file
}

fn -run-installer { |requested-packages|
  echo 📦 Installing packages...

  command:silence {
    sudo apt-get install -y $@requested-packages
  }

  echo ✅ Packages installed!
}

fn install { |inputs|
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
