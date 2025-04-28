use str
use ../console
use ./pipx

fn -install { |version|
  pipx:install-package pdm &version=$version
}

fn ensure-version { |&version=$nil|
  if (not (has-external pdm)) {
    echo 💬pdm is not there: now installing it!
    -install $version
    return
  }

  echo 🌟pdm is already installed!

  var installed-version = (pdm --version)
  console:inspect 'Installed pdm version' $installed-version

  if (and $version (str:contains installed-version $version)) {
    echo ✅The requested pdm version is already installed!
    return
  }

  -install $version
}