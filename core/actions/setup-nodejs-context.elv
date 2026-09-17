use os
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/seq
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/astral-bridge/v2/nvm
use github.com/giancosta86/astral-bridge/v2/nodejs/package-manager

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

  var node-version = (seq:drill-down $package-json engines node)

  if (not $node-version) {
    fail 'package.json must contain the "engines/node" field!'
  }

  var package-manager = (package-manager:detect-from-package-json)

  if (not $package-manager) {
    fail 'package.json must contain a field describing the package manager!'
  }

  put [
    &node-version=$node-version
    &package-manager=$package-manager
  ]
}

fn ensure-nvm {
  console:section &emoji=🚢 'nvm version' {
    nvm:nvm --version
  }
}

fn install-node { |node-version|
  echo 📥 Installing NodeJS '('$node-version')'...

  command:silence {
    nvm:nvm install $node-version
  }

  # The path set by nvm must be preserved all over the workflow
  env:cascade PATH

  echo 🚀 NodeJS ready!

  console:section &emoji=🎡 'NodeJS version' {
    node --version
  }
}

fn setup-corepack { |corepack-version|
  echo 📥 Now installing corepack@$corepack-version...

  command:silence {
    npm install --global corepack@$corepack-version
  }

  echo 🎉 corepack@$corepack-version installed!

  console:section &emoji=🔮 'corepack version' {
    corepack --version
  }

  echo 🔗 Enabling corepack...

  command:silence {
    corepack enable
  }

  echo 🟢 corepack enabled!
}

fn ensure-package-manager { |package-manager|
  console:section &emoji=📦 'Package manager ('$package-manager')' {
    package-manager:exec --version
  }
}

fn install-dependencies { |package-manager|
  echo 📥 Installing the project dependencies...

  command:silence {
    if (eq $package-manager npm) {
      npm ci
    } else {
      package-manager:exec install
    }
  }

  echo 🎉 Dependencies installed!
}

fn main {
  var corepack-version = (input:string corepack-version)

  var install-dependencies = (input:bool install-dependencies)

  check-directory-structure

  var requested-tools = (check-package-json)

  ensure-nvm

  install-node $requested-tools[node-version]

  setup-corepack $corepack-version

  ensure-package-manager $requested-tools[package-manager]

  if $install-dependencies {
    install-dependencies $requested-tools[package-manager]
  } else {
    echo 💭 Skipping installation of the project dependencies...
  }

  echo ✅📦 NodeJS context in "'"$pwd"'" ready!
}