use os
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang
use github.com/giancosta86/aurora-elvish/nvm/node-version
use github.com/giancosta86/aurora-elvish/seq
use ../ci-cd/env

fn check-preconditions {
  console:echo 📦💻 Setting up NodeJS context in "'"$pwd"'"...

  if (not (os:is-regular package.json)) {
    fail 'The package.json descriptor is missing!'
  }
}

fn detect-nodejs-constraints {
  var requested-node-version = (node-version:detect-in-pwd)

  var install-toolchain

  if $requested-node-version {
    console:inspect 'Requested NodeJS version' $requested-node-version
    set install-toolchain = true
  } else {
    console:echo 💭 No requested NodeJS version...
    set install-toolchain = false
  }

  console:inspect 'Install NodeJS toolchain' $install-toolchain

  put [
    &install-toolchain=$install-toolchain
    &requested-node-version=$requested-node-version
  ]
}

fn detect-pnpm-constraints {
  var package-manager-reference = (jq -r '.packageManager // ""' package.json)

  console:inspect &emoji=📦 'Package manager reference' $package-manager-reference

  var requested-pnpm-version

  if (seq:is-non-empty $package-manager-reference) {
    var requested-package-manager requested-package-manager-version = (
      echo $package-manager-reference | str:split @ (all)
    )

    if (!=s $requested-package-manager pnpm) {
      fail 'The package manager must be pnpm!'
    }

    set requested-pnpm-version = $requested-package-manager-version

    console:inspect 'Requested pnpm version' $requested-pnpm-version
  } else {
    console:echo 🌟 Defaulting to the latest pnpm version!
    set requested-pnpm-version = latest
  }

  console:inspect &emoji=🔬 'pnpm version to install' $requested-pnpm-version

  put [
    &requested-pnpm-version=$requested-pnpm-version
  ]
}

fn set-pnpm-colors { |enabled|
  var key = FORCE_COLOR
  var value = (lang:ternary $enabled 1 0)

  set-env $key $value
  env:write $key $value
}

fn install-dependencies {
  var lockfile = pnpm-lock.yaml

  var lockfile-arg

  if (os:is-regular $lockfile) {
    console:echo 🧊 Installing dependencies with frozen lockfile, as "'"$lockfile"'" is present...
    set lockfile-arg = --frozen-lockfile
  } else {
    console:echo 🌞 Installing dependencies without frozen lockfile, as "'"$lockfile"'" is missing...
    set lockfile-arg = --no-frozen-lockfile
  }

  pnpm install $lockfile-arg

  console:echo ✅ Dependencies installed!
}
