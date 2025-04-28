use os
use str
use ./console
use ./command

fn -should-run-installer { |required-command|
  if $required-command {
    console:inspect &emoji=📥 'Required command' $required-command

    if ?(bash -c 'type '$required-command' >/dev/null 2>&1') {
      console:echo ✅Required command available - no need to install it!
      put $false
      return
    } else {
      console:echo 💬Required command not available - now installing its packages...
    }
  } else {
    console:echo 💫No required command passed - the requested packages will be installed unconditionally
  }

  put $true
}

fn -run-initial-update {
  var flag-file = ~/.install-system-packages-updated

  if (os:is-regular $flag-file) {
    echo 💡The package list has already been updated!
    return
  }

  echo 📥Updating the package list...

  command:show-log-on-error 'sudo apt-get update'

  touch $flag-file
}

fn -run-installer { |requested-packages|
  console:inspect &emoji=📥 'Requested packages' $requested-packages
  var space-separated-packages = (str:join ' ' $requested-packages)
  console:inspect &emoji=📦 'Installing packages' $space-separated-packages

  command:show-log-on-error 'sudo apt-get install -y '$space-separated-packages

  echo ✅Packages installed!
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








