use os
use str
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/gauntlet/v1/input

fn get-npm-scope-args { |npm-scope|
  var npm-scope-arg = (
    str:trim-left $npm-scope @
  )

  console:inspect &emoji=☂ 'NPM scope' $npm-scope-arg >&2

  eq $npm-scope-arg '<ROOT>' |
    lang:ternary (all) [] ['--scope' $npm-scope-arg]
}

fn run-wasm-pack { |inputs|
  var target = $inputs[target]
  var target-directory = $inputs[target-directory]
  var development = $inputs[development]
  var npm-scope = $inputs[npm-scope]

  var mode-arg = (
    lang:ternary $development --dev --release
  )

  var npm-scope-args = (get-npm-scope-args $npm-scope)

  wasm-pack build --target $target $mode-arg $@npm-scope-args --out-dir $target-directory
}

fn try-to-update-package-json { |inputs|
  tmp pwd = pkg

  if (not (os:is-regular package.json)) {
    return
  }

  var node-version = $inputs[node-version]
  var package-manager = $inputs[package-manager]

  if (or $node-version $package-manager) {
    var package-json = (from-json < package.json)

    if $node-version {
      console:inspect &emoji=🧬 'Injecting the requested NodeJS version' $node-version

      var engines = (
        lang:get-value $package-json engines |
          coalesce (all) [&]
      )

      set package-json = (
        assoc $engines node $node-version |
          assoc $package-json engines (all)
      )
    }

    if $package-manager {
      console:inspect &emoji=🧬 'Injecting the requested package manager' $package-manager

      set package-json = (assoc $package-json packageManager $package-manager)
    }

    put $package-json |
      lang:to-json > package.json
  }
}

fn try-to-copy-special-root-files { |target-directory|
  var root-files-to-copy = [
    .npmrc
  ]

  all $root-files-to-copy |
    keep-if $os:is-regular~ |
    each { |source-path|
      cp $source-path $target-directory

      echo 📜 "'"$source-path"'" copied to target directory!
    }
}

fn main {
  echo 📦 Generating the WebAssembly project files...

  var target = (input:string target)
  var target-directory = (input:string target-directory)
  var development = (input:bool development)
  var npm-scope = (input:string npm-scope)
  var node-version = (input:string &optional node-version)
  var package-manager = (input:string &optional package-manager)

  run-wasm-pack [
    &target=$target
    &target-directory=$target-directory
    &development=$development
    &npm-scope=$npm-scope
  ]

  try-to-update-package-json [
    &node-version=$node-version
    &package-manager=$package-manager
  ]

  try-to-copy-special-root-files $target-directory

  console:inspect &emoji=✅ 'WebAssembly target ready in' $target-directory
}
