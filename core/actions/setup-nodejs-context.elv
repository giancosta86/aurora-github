use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/astral-bridge/v1/corepack
use github.com/giancosta86/astral-bridge/v1/nvm
use github.com/giancosta86/astral-bridge/v1/package-manager
use github.com/giancosta86/astral-bridge/v1/version/requested

var nvm~ = $nvm:nvm~

var nvm-setup-command = 'wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash'

fn ensure-nvm {
  if (command:exists-in-bash nvm) {
    echo 🌟 nvm already available!
  } else {
    echo 📥 Installing nvm...

    command:silence {
      bash -c $nvm-setup-command
    }

    echo 🚀 nvm ready!
  }

  console:section &emoji=🚢 'nvm version' {
    nvm --version
  }
}

fn ensure-node {
  var requested-node-version = (requested:detect-recursively $pwd)

  if $requested-node-version {
    console:inspect &emoji=🏷️ 'Requested NodeJS version' $requested-node-version

    ensure-nvm

    echo 📥 Installing NodeJS...

    command:silence {
      nvm install $requested-node-version
    }

    env:set PATH (get-env PATH)

    echo 🚀 NodeJS ready!
  } else {
    echo 💭 No specific NodeJS version requested...

    if (has-external node) {
      echo 🌟 NodeJS is already on the system!
    } else {
      ensure-nvm

      command:silence {
        nvm install latest
      }

      env:set PATH (get-env PATH)
    }
  }

  console:section &emoji=🎡 'NodeJS version' {
    node --version
  }
}

fn prepare-corepack { |corepack-version|
  if $corepack-version {
    echo 📥 Now installing corepack@$corepack-version...

    command:silence {
      npm install --global corepack@$corepack-version
    }

    echo 🎉 corepack installed!
  } else {
    echo 💭 Skipping corepack installation, as it was not requested...
  }

  if (has-external corepack) {
    console:section &emoji=🔮 'corepack version' {
      corepack --version
    }

    echo ⚙️ Setting up corepack...

    command:silence {
      corepack:setup
    }

    echo 🚀 corepack ready!
  } else {
    echo 💭 corepack not available on the system...
  }
}

fn ensure-package-manager {
  var detected-package-manager = (
    package-manager:detect |
      coalesce (all) npm
  )

  console:section &emoji=📦 'Package manager ('$detected-package-manager')' {
    package-manager:exec --version
  }
}

fn install-dependencies {
  echo 📥 Installing the project dependencies...

  command:silence {
    package-manager:exec install
  }

  echo 🎉 Dependencies installed!
}

fn main {
  var corepack-version = (input:string &optional corepack-version)
  var install-dependencies = (input:bool install-dependencies)

  ensure-node

  prepare-corepack $corepack-version

  ensure-package-manager

  if $install-dependencies {
    install-dependencies
  } else {
    echo 💭 Skipping installation of the project dependencies...
  }

  echo ✅📦 NodeJS context in "'"$pwd"'" ready!
}