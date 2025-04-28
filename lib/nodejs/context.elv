use os
use ../seq
use ../console
use ../env
use ../lang

fn set-pnpm-colors { |enabled|
  var key = FORCE_COLOR
  var value = (lang:ternary $enabled 1 0)

  set-env $key $value
  env:write $key $value
}


fn check-preconditions {
  if (not (os:is-regular package.json)) {
    fail 'The package.json descriptor is missing!'
  }
}

fn detect-nodejs-constraints {
  var requested-node-version = (jq -r '.engines.node // ""' package.json)

  var install-toolchain

  if (seq:is-non-empty $requested-node-version) {
    console:inspect 'NodeJS version requested in package.json' $requested-node-version
    set install-toolchain = true
  } else {
    console:echo 💭No requested NodeJS version in package.json...
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
    var requested-package-manager = (echo $package-manager-reference | cut -d '@' -f 1)

    if (!=s $requested-package-manager pnpm) {
      fail 'The package manager must be pnpm!'
    }

    set requested-pnpm-version = (echo $package-manager-reference | cut -d '@' -f 2)

    console:inspect 'Requested pnpm version' $requested-pnpm-version
  } else {
    console:echo 🌟Defaulting to the latest pnpm version!
    set requested-pnpm-version = latest
  }

  console:inspect &emoji=🔬 'pnpm version to install' $requested-pnpm-version

  put [
    &requested-pnpm-version=$requested-pnpm-version
  ]
}

fn install-dependencies {
  var lockfile = pnpm-lock.yaml

  var lockfile-arg

  if (os:is-regular $lockfile) {
    echo 🧊Installing dependencies with frozen lockfile, as "'"$lockfile"'" is present...
    set lockfile-arg = --frozen-lockfile
  } else {
    echo 🌞Installing dependencies without frozen lockfile, as "'"$lockfile"'" is missing...
    set lockfile-arg = --no-frozen-lockfile
  }

  pnpm install $lockfile-arg

  echo ✅Dependencies installed!
}


