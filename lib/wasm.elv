use os
use ./console
use ./lang
use ./seq
use ./files
use ./nodejs/npm

fn install-wasm-pack { |version|
  echo 🌐Installing wasm-pack $version...

  npm install -g 'wasm-pack@'$version

  echo ✅wasm-pack installed!

  echo 🔎Now ensuring wasm-pack is available...

  wasm-pack --version

  echo ✅wasm-pack ready!
}

fn -generate-target-via-wasm-pack { |inputs|
  echo 📦Generating the WebAssembly project files...

  var development = $inputs[development]
  var npm-scope = $inputs[npm-scope]
  var target = $inputs[target]
  var target-directory = $inputs[target-directory]
  var npm-scope = $inputs[npm-scope]

  var mode-arg = (
    lang:ternary $development '--dev' '--release'
  )

  var actual-npm-scope = (npm:parse-scope $npm-scope)

  var npm-scope-args = (
    lang:ternary (seq:is-non-empty $actual-npm-scope) ['--scope' $inputs[npm-scope]] []
  )

  wasm-pack build --target $target $mode-arg $@npm-scope-args --out-dir $target-directory
}

fn -inject-nodejs-version { |nodejs-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested NodeJS version!'
  }

  console:inspect &emoji=🧬 'Injecting the requested NodeJS version' $nodejs-version

  files:jq-edit package.json '.engines.node = "'$nodejs-version'"'
}

fn -inject-pnpm-version { |pnpm-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested pnpm version!'
  }

  console:inspect &emoji=🧬 'Injecting the requested pnpm version' $pnpm-version

  files:jq-edit package.json '.packageManager = "pnpm@'$pnpm-version'"'
}

fn -try-to-display-package-json { |target|
  if (os:is-regular package.json) {
    console:section &emoji=📦 "Generated package.json descriptor for the '"$target"' target:" {
      jq -C . package.json
    }
  } else {
    echo "💭No package.json descriptor generated for the '"$target"' target..."
  }
}

fn generate-target { |inputs|
  console:inspect-inputs $inputs

  var target-directory = $inputs[target-directory]
  var nodejs-version = $inputs[nodejs-version]
  var pnpm-version = $inputs[pnpm-version]
  var target = $inputs[target]

  -generate-target-via-wasm-pack $inputs

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