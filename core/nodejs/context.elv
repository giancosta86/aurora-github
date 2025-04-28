use os
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang
use github.com/giancosta86/aurora-elvish/seq
use ../ci-cd/env

fn check-preconditions {
  console:echo 📦💻 Setting up NodeJS context in "'"$pwd"'"...

  if (not (os:is-regular package.json)) {
    fail 'The package.json descriptor is missing!'
  }
}

fn -detect-node-version-from-package-json {
  var requested-node-version = (jq -r '.engines.node // ""' package.json)

  if (seq:is-non-empty $requested-node-version) {
    console:inspect 'NodeJS version requested in package.json' $requested-node-version
    put $requested-node-version
  } else {
    console:echo 💭 No 'engines/node' field in package.json...
    put $nil
  }
}

fn -detect-node-version-from-nvmrc {
  if (os:is-regular .nvmrc) {
    var requested-node-version = (slurp < .nvmrc | str:trim-space (all))

    console:inspect 'Requested version in the .nvmrc file' $requested-node-version

    lang:ternary (seq:is-non-empty $requested-node-version) $requested-node-version $nil
  } else {
    console:echo 💭 No .nvmrc file...
    put $nil
  }
}

fn detect-nodejs-constraints {
  var requested-node-version = (
    coalesce (
      -detect-node-version-from-nvmrc
    ) (
      -detect-node-version-from-package-json
    )
  )

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
