use os
use path
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/highlighting
use github.com/giancosta86/aurora-elvish/resources

var -resources = (resources:for-script (src))

var -user-settings-path = ~/.m2/settings.xml

var -user-settings-filename = (path:base $-user-settings-path)

fn -copy-default-settings {
  console:echo 🌟 Providing a default settings file for 🪶 Maven...

  var default-settings-path = ($-resources[get-path] $-user-settings-filename)

  cp $default-settings-path $-user-settings-path

  console:section &emoji=🪶 'Content of the per-user Maven settings file' {
    cat $-user-settings-path | highlighting:highlight xml
  }
}

fn -check-server-in-pom {
  var server-name = target-server

  if (slurp < pom.xml | str:contains (all) $server-name) {
    console:echo ✅ Server "'"$server-name"'" found in pom.xml!
  } else {
    console:echo 💭 Server "'"$server-name"'" not mentioned in pom.xml...
  }
}

fn prepare-for-publication {
  console:echo 🪶 Preparing Maven settings for publication...

  if (os:is-regular $-user-settings-path) {
    console:inspect &emoji=🌟 'Maven settings file found at' $-user-settings-path
    return
  }

  os:mkdir-all (path:dir $-user-settings-path)

  if (os:is-regular $-user-settings-filename) {
    console:echo 📃 Maven settings file found in the current directory! Now copying it...

    cp $-user-settings-filename $-user-settings-path
  } else {
    -copy-default-settings

    -check-server-in-pom
  }

  console:echo ✅ Maven settings now ready!
}
