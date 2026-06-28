use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console

fn install-package { |package &version=$nil|
  echo 📥 Installing $package via pipx...

  var version-suffix

  if $version {
    console:inspect &emoji=🏷 'Requested version' $version
    set version-suffix = '=='$version
  } else {
    echo 🌟 Installing the latest version...
    set version-suffix = ''
  }

  command:silence {
    pipx install $package''$version-suffix
  }

  echo ✅ $package installed!
}