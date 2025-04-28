use os
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/edit
use github.com/giancosta86/aurora-elvish/lang
use ../nodejs/pnpm
use ../project/descriptors/json

fn install { |version|
  console:echo 🌐 Installing wasm-pack $version...

  npm install -g 'wasm-pack@'$version

  console:echo ✅ wasm-pack installed!
}

fn -run { |inputs|
  console:echo 📦 Generating the WebAssembly project files...

  var target = $inputs[target]
  var npm-scope = $inputs[npm-scope]
  var development = $inputs[development]
  var target-directory = $inputs[target-directory]

  var mode-arg = (
    lang:ternary $development '--dev' '--release'
  )

  var actual-npm-scope = (pnpm:parse-scope $npm-scope)

  var npm-scope-args = (
    lang:ternary $actual-npm-scope ['--scope' $actual-npm-scope] []
  )

  wasm-pack build --target $target $mode-arg $@npm-scope-args --out-dir $target-directory
}

fn -inject-nodejs-version { |nodejs-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested NodeJS version!'
  }

  console:inspect &emoji=🧬 'Injecting the requested NodeJS version' $nodejs-version

  edit:json package.json '.engines.node = "'$nodejs-version'"'
}

fn -inject-pnpm-version { |pnpm-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested pnpm version!'
  }

  console:inspect &emoji=🧬 'Injecting the requested pnpm version' $pnpm-version

  edit:json package.json '.packageManager = "pnpm@'$pnpm-version'"'
}

fn -try-to-display-package-json { |target|
  if (os:is-regular package.json) {
    console:section &emoji=📦 'Generated package.json descriptor for the '''$target''' target' {
      json:print-content package.json
    }
  } else {
    console:echo 💭 No package.json descriptor generated for the "'"$target"'" target...
  }
}

fn run-browser-tests {
  console:echo 🌐 Running headless browser tests...

  wasm-pack test --chrome --headless --release

  console:echo ✅ Headless browser tests OK!
}

fn generate-target { |inputs|
  console:inspect-inputs $inputs

  -run $inputs

  var target = $inputs[target]
  var nodejs-version = $inputs[nodejs-version]
  var pnpm-version = $inputs[pnpm-version]
  var target-directory = $inputs[target-directory]

  tmp pwd = $target-directory

  if $nodejs-version {
    -inject-nodejs-version $nodejs-version
  }

  if $pnpm-version {
    -inject-pnpm-version $pnpm-version
  }

  -try-to-display-package-json $target

  console:inspect &emoji=✅ 'WebAssembly target ready in' $target-directory
}