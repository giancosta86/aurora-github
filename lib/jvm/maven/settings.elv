use os
use path
use str
use ../../console

var -settings-file = ~/.m2/settings.xml

fn -copy-default-settings { |default-settings-path|
  cp $default-settings-path $-settings-file

  console:section &emoji=🪶 'Content of the default Maven settings' {
    cat $-settings-file
  }
}

fn -check-server-in-pom {
  var server-name = target-server

  if (slurp < pom.xml | str:contains (all) $server-name) {
    echo ✅Server "'"$server-name"'" found in pom.xml!
  } else {
    echo 💭Server "'"$server-name"'" not mentioned in pom.xml...
  }
}

fn enforce { |default-settings-path|
  echo 🪶Enforcing Maven settings...

  if (os:is-regular $-settings-file) {
    console:inspect &emoji=🌟 'Maven settings file found at' $-settings-file
    return
  }

  os:mkdir-all (path:dir $-settings-file)

  var settings-in-current-directory = (path:base $-settings-file)

  if (os:is-regular $settings-in-current-directory) {
    echo 📃Maven settings file found in the project directory! Now copying it...

    cp $settings-in-current-directory $-settings-file
  } else {
    echo 🌟Providing a default settings file for 🪶Maven...

    -copy-default-settings $default-settings-path

    -check-server-in-pom
  }

  echo ✅Maven settings file now ready!
}
