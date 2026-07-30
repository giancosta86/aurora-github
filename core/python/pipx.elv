use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/lang

fn install-package { |package &version=$nil|
  if (not (has-external pipx)) {
    echo 📥 Installing pipx...

    command:silence {
      python3 -m pip install pipx
    }

    echo 🚀 pipx ready!
  }

  coalesce $version latest |
    echo 📥 Installing $package '('(all)')' via pipx...

  var version-suffix = (
    lang:ternary $version '=='$version ''
  )

  command:silence {
    pipx install $package''$version-suffix
  }

  echo ✅ $package installed!
}