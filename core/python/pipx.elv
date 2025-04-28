use github.com/giancosta86/aurora-elvish/console

fn install-package { |package &version=$nil|
  console:echo 📥 Installing $package via pipx...

  var version-suffix

  if $version {
    console:inspect &emoji=🏷 'Requested version' $version
    set version-suffix = '=='$version
  } else {
    console:echo 🌟 Installing the latest version
    set version-suffix = ''
  }

  pipx install $package''$version-suffix

  console:echo ✅ $package installed!
}