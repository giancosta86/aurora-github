use github.com/giancosta86/ethereal/v1/lang

fn -ensure-pipx {
  if (not (has-external pipx)) {
    echo 📥 Installing pipx...

    python3 -m pip install pipx

    echo 🚀 pipx ready!
  }
}

fn install-package { |package &version=$nil|
  -ensure-pipx

  coalesce $version latest |
    echo 📥 Installing $package '('(all)')' via pipx...

  var version-suffix = (
    lang:ternary $version '=='$version ''
  )

  pipx install $package''$version-suffix

  echo ✅ $package installed!
}