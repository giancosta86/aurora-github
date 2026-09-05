use os
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/seq
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/astral-bridge/v1/corepack
use github.com/giancosta86/astral-bridge/v1/nvm
use github.com/giancosta86/astral-bridge/v1/package-manager
use github.com/giancosta86/astral-bridge/v1/version/requested

var nvm~ = $nvm:nvm~

fn check-directory-structure {
  if (os:is-regular .nvmrc) {
    fail 'The .nvmrc file is not admitted: use the "engines/node" field in package.json instead!'
  }
}

fn check-package-json {
  if (not (os:is-regular package.json)) {
    fail 'package.json must exist!'
  }

  var package-json = (
    from-json < package.json
  )

  if (not (seq:drill-drown $package-json engines node)) {
    fail 'package.json must contain the "engines/node" field!'
  }

  if (not (seq:drill-down packageManager)) {
    fail 'package.json must contain the "packageManager" field!'
  }
}

fn ensure-nvm {
  if (command:exists-in-bash nvm) {
    echo 🌟 nvm already available!
  } else {
    echo 📥 Installing nvm...

    var nvm-setup-command = 'wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash'

    command:silence {
      bash -c $nvm-setup-command
    }

    echo 🚀 nvm ready!
  }

  console:section &emoji=🚢 'nvm version' {
    nvm --version
  }
}

fn install-node {
  var requested-node-version = (
    from-json < package.json
  )[engines][node]

  echo 📥 Installing NodeJS '('$requested-node-version')'...

  command:silence {
    nvm install $requested-node-version
  }

  # The path set by nvm must be preserved all over the workflow
  env:cascade PATH |

  echo 🚀 NodeJS ready!

  console:section &emoji=🎡 'NodeJS version' {
    node --version
  }
}

fn configure-corepack { |corepack-version|
  echo 📥 Now installing corepack@$corepack-version...

  command:silence {
    npm install --global corepack@$corepack-version
  }

  echo 🎉 corepack installed!

  console:section &emoji=🔮 'corepack version' {
    corepack --version
  }

  echo ⚙️ Setting up corepack...

  command:silence {
    corepack:setup
  }

  echo 🚀 corepack ready!
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
  var corepack-version = (input:string corepack-version)

  var install-dependencies = (input:bool install-dependencies)

  check-directory-structure

  check-package-json

  ensure-nvm

  install-node

  configure-corepack $corepack-version

  ensure-package-manager

  if $install-dependencies {
    install-dependencies
  } else {
    echo 💭 Skipping installation of the project dependencies...
  }

  echo ✅📦 NodeJS context in "'"$pwd"'" ready!
}