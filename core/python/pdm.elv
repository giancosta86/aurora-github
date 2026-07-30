use re
use github.com/giancosta86/ethereal/v1/console
use ./pipx

fn -install { |version|
  pipx:install-package &version=$version pdm
}

fn ensure { |&version=$nil|
  if (has-external pdm) {
    var installed-version = (pdm --version)
    console:inspect &emoji=📦 'Installed pdm version' $installed-version

    var version-found = (
      and $version (re:match '(?:^|\s)'$version'(?:\s|$)' $installed-version)
    )

    if $version-found {
      echo ✅ The requested pdm version is already installed!
    } else {
      -install $version
    }
  } else {
    echo 💬 pdm is not available: now installing it!
    -install $version
  }
}