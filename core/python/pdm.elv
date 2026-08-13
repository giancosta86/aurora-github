use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/semver
use ./pipx

fn -install { |version|
  command:silence {
    pipx:install-package &version=$version pdm
  }
}

fn ensure { |&version=$nil|
  if (has-external pdm) {
    var installed-version = (pdm --version)
    console:inspect &emoji=📦 'Current pdm version' $installed-version

    if $version {
      var version-found = (
        put $installed-version |
          semver:contains $version
      )

      if $version-found {
        echo ✅ The requested pdm version '('$version')' is already installed!
      } else {
        -install $version
      }
    } else {
      echo 💬 No specific pdm version requested...
    }
  } else {
    echo 💬 pdm is not available: now installing it!
    -install $version
  }
}