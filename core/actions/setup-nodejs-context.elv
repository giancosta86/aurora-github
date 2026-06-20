use os
use github.com/giancosta86/aurora-github/ci-cd/env
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/astral-bridge/v1/corepack
use github.com/giancosta86/astral-bridge/v1/nvm
use github.com/giancosta86/astral-bridge/v1/package-manager
use github.com/giancosta86/astral-bridge/v1/version/requested
use ../std-err
use ./input

var nvm~ = $nvm:nvm~

var nvm-setup-command = 'wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash'

fn ensure-nvm {
  if (not (command:exists-in-bash nvm)) {
    std-err:echo 📥 Installing nvm...

    command:silence {
      bash -c $nvm-setup-command
    }

    std-err:echo 🚀 nvm ready!
  } else {
    std-err:echo 🌟 nvm already available!
  }

  std-err:section &emoji=🚢 'nvm version' {
    nvm --version
  }
}

fn ensure-node {
  var requested-node-version = (requested:detect-recursively $pwd)

  if $requested-node-version {
    std-err:inspect &emoji=🏷️ 'Requested NodeJS version' $requested-node-version

    ensure-nvm

    std-err:echo 📥 Installing NodeJS...

    command:silence {
      nvm install $requested-node-version

      env:write PATH (get-env PATH)
    }

    std-err:echo 🚀 NodeJS ready!
  } else {
    std-err:echo 💭 No specific NodeJS version requested...

    if (not (has-external node)) {
      ensure-nvm

      nvm install latest

      env:write PATH (get-env PATH)
    }
  }

  std-err:section &emoji=🎡 'NodeJS version' {
    node --version
  }
}

fn setup-corepack { |corepack-version|
  if $corepack-version {
    std-err:echo 📥 Now installing corepack@$corepack-version...

    command:silence {
      npm install --global corepack@$corepack-version
    }

    std-err:echo 🎉 corepack installed!
  } else {
    std-err:echo 💭 Skipping corepack installation...
  }

  if (has-external corepack) {
    std-err:section &emoji=🔮 'corepack version' {
      corepack --version
    }

    std-err:echo ⚙️ Setting up corepack...

    command:silence {
      corepack:setup
    }

    std-err:echo 🚀 corepack ready!
  } else {
    std-err:echo 💭 corepack not available
  }
}

fn ensure-package-manager {
  var detected-package-manager = (
    package-manager:detect |
      coalesce (all) npm
  )

  std-err:section &emoji=📦 'Package manager ('$detected-package-manager')' {
    package-manager:exec --version
  }
}

fn install-dependencies {
  std-err:echo 📥 Installing the project dependencies...

  command:silence {
    package-manager:exec install
  }

  std-err:echo 🎉 Dependencies installed!
}

fn main {
  var corepack-version = (input:string &optional corepack-version)
  var install-dependencies = (input:bool install-dependencies)

  ensure-node

  setup-corepack $corepack-version

  ensure-package-manager

  if $install-dependencies {
    install-dependencies
  } else {
    echo 💭 Skipping installation of the project dependencies...
  }

  std-err:echo ✅📦 NodeJS context in "'"$pwd"'" ready!
}