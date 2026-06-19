use ../std-err
use ./input

fn run-wasm-pack { |inputs|
  var target = $inputs[target]
  var target-directory = $inputs[target-directory]
  var development = $inputs[development]
  var npm-scope = $inputs[npm-scope]

  var mode-arg = (
    lang:ternary $development '--dev' '--release'
  )

  var actual-npm-scope = (pnpm:parse-scope $npm-scope)

  var npm-scope-args = (
    lang:ternary $actual-npm-scope ['--scope' $actual-npm-scope] []
  )

  wasm-pack build --target $target $mode-arg $@npm-scope-args --out-dir $target-directory
}

fn try-to-copy-package-json { |target-directory|
  if (os:is-regular package.json) {
    echo 📜 Root package.json file found! Copying it to $target-directory...

    cp package.json $target-directory

    echo 🎉 package.json copied!
  }
}

fn main {
  echo 📦 Generating the WebAssembly project files...

  var target = (input:string target)
  var target-directory = (input:string target-directory)
  var development = (input:bool development)
  var npm-scope = (input:string &optional npm-scope)

  run-wasm-pack [
    &target=$target
    &target-directory=$target-directory
    &development=$development
    &npm-scope=$npm-scope
  ]

  try-to-copy-package-json

  std-err:inspect &emoji=✅ 'WebAssembly target ready in' $target-directory
}
