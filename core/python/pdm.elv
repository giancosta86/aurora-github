use re
use ../std-err
use ./pipx

fn -install { |version|
  pipx:install-package &version=$version pdm
}

fn ensure { |&version=$nil|
  if (not (has-external pdm)) {
    echo 💬 pdm is not available: now installing it!
    -install $version
    return
  }

  echo 🌟 pdm is already installed!

  var installed-version = (pdm --version)
  std-err:inspect 'Installed pdm version' $installed-version

  if (and $version (re:match '\b'$version'\b' installed-version )) {
    echo ✅ The requested pdm version is already installed!
    return
  }

  -install $version
}