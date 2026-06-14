use github.com/giancosta86/aurora-github/ci-cd/env
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/astral-bridge/v1/corepack
use github.com/giancosta86/astral-bridge/v1/nvm
use github.com/giancosta86/astral-bridge/v1/package-manager
use github.com/giancosta86/astral-bridge/v1/version/requested
use ../std-err

var -nvm-setup-command = 'wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash'

fn -ensure-nvm {
  if (not (command:exists-in-bash nvm)) {
    std-err:echo 📥 Installing nvm...

    command:silence {
      bash -c $-nvm-setup-command
    }

    std-err:echo 🚀 nvm installed!
  } else {
    std-err:echo 🌟 nvm already installed!
  }
}

fn -ensure-node {
  var requested-node-version = (requested:detect-recursively $pwd)

  if $requested-node-version {
    std-err:inspect &emoji=🏷️ 'Requested NodeJS version' $requested-node-version

    command:silence {
      nvm:nvm install $requested-node-version
    }
  } else {
    std-err:echo 💭 No specific NodeJS version requested...
  }

  std-err:section &emoji=🎡 'NodeJS version' {
    node --version
  }
}

fn -ensure-package-manager {
  command:silence {
    npm install --global corepack
  }

  command:silence {
    corepack:setup
  }

  std-err:section &emoji=📦 'Package manager version' {
    package-manager:exec --version
  }
}

fn -save-path-updated-by-nvm {
  env:write PATH (get-env PATH)
}

fn -install-packages {
  std-err:echo 📥 Installing the project packages...

  command:silence {
    package-manager:exec install
  }

  std-err:echo 🎉 Packages installed!
}

fn main {
  -ensure-nvm

  -ensure-node

  -ensure-package-manager

  -save-path-updated-by-nvm

  -install-packages

  std-err:echo ✅📦 NodeJS context in "'"$pwd"'" ready!
}