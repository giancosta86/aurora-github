use ../std-err

fn install-package { |package &version=$nil|
  echo 📥 Installing $package via pipx...

  var version-suffix

  if $version {
    std-err:inspect &emoji=🏷 'Requested version' $version
    set version-suffix = '=='$version
  } else {
    echo 🌟 Installing the latest version...
    set version-suffix = ''
  }

  pipx install $package''$version-suffix

  echo ✅ $package installed!
}