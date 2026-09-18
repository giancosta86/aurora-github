use os
use path
use str
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/highlight
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/ethereal/v1/map

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

fn merge-package-json { |generated-package-json-path|
  var generated-package-json = (
    from-json < $generated-package-json-path
  )

  var manual-package-json = (
    from-json < package.json
  )

  all [
    $generated-package-json

    $manual-package-json
  ] |
    map:merge |
    lang:to-json > $generated-package-json-path
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

  run-wasm-pack [
    &target=$target
    &target-directory=$target-directory
    &development=$development
    &npm-scope=$npm-scope
  ]

  var generated-package-json-path = (path:join pkg package.json)

  if (os:is-regular $generated-package-json-path) {
    merge-package-json $generated-package-json-path
  } else {
    echo 💭 No package.json file was generated...
  }

  try-to-copy-special-root-files $target-directory

  console:inspect &emoji=✅ 'WebAssembly target ready in' $target-directory
}
