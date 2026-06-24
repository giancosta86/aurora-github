use os
use path
use str
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/resources
use ../../highlight
use ../../std-err

var -resources = (resources:for-script (src))

var -user-settings-path = ~/.m2/settings.xml

var -user-settings-filename = (path:base $-user-settings-path)

fn -copy-default-settings {
  echo 🌟 Providing a default settings file for 🪶 Maven...

  var default-settings-path = ($-resources[get-path] $-user-settings-filename)

  fs:copy $default-settings-path $-user-settings-path

  std-err:section &emoji=🪶 'Content of the per-user Maven settings file' {
    highlight:file $-user-settings-path xml
  }
}

fn -check-server-in-pom {
  var server-name = target-server

  if (slurp < pom.xml | str:contains (all) $server-name) {
    echo ✅ Server "'"$server-name"'" found in pom.xml!
  } else {
    echo 💭 Server "'"$server-name"'" not mentioned in pom.xml...
  }
}

fn prepare-for-publication {
  echo 🪶 Preparing Maven settings for publication...

  if (os:is-regular $-user-settings-path) {
    std-err:inspect &emoji=🌟 'Maven settings file found at' $-user-settings-path
    return
  }

  os:mkdir-all (path:dir $-user-settings-path)

  if (os:is-regular $-user-settings-filename) {
    echo 📃 Maven settings file found in the current directory! Now copying it...

    fs:copy $-user-settings-filename $-user-settings-path
  } else {
    -copy-default-settings

    -check-server-in-pom
  }

  echo ✅ Maven settings now ready!
}
