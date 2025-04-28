use re
use github.com/giancosta86/aurora-elvish/console
use ./pipx

fn -install { |version|
  pipx:install-package &version=$version pdm
}

fn ensure { |&version=$nil|
  if (not (has-external pdm)) {
    console:echo 💬 pdm is not available: now installing it!
    -install $version
    return
  }

  console:echo 🌟 pdm is already installed!

  var installed-version = (pdm --version)
  console:inspect 'Installed pdm version' $installed-version

  if (and $version (re:match '\b'$version'\b' installed-version )) {
    console:echo ✅ The requested pdm version is already installed!
    return
  }

  -install $version
}