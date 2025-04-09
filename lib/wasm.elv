use os
use ./console
use ./core

fn install-wasm-pack { |version|
  echo 🌐Installing wasm-pack $version...

  npm install -g "wasm-pack@"$version

  echo ✅wasm-pack installed!

  echo 🔎Now ensuring wasm-pack is available...

  wasm-pack --version

  echo ✅wasm-pack ready!
}

fn -generate-target-via-wasm-pack { |inputs|
  echo 📦Generating the WebAssembly project files...

  var mode-arg = (
    core:ternary (eq $inputs[development] true) '--dev' '--release'
  )

  var npm-scope-args = (
    core:ternary (not-eq $inputs[npm-scope] '') ['--scope' $inputs[npm-scope]] []
  )

  wasm-pack build --target $inputs[target] $mode-arg $@npm-scope-args --out-dir $inputs[target-directory]
}

fn -inject-nodejs-version { |nodejs-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested NodeJS version!'
  }

  console:inspect &icon=🧬 'Injecting the requested NodeJS version' $nodejs-version

  jq '.engines.node = "'$nodejs-version'"' package.json | slurp > package.json
}

fn -inject-pnpm-version { |pnpm-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested pnpm version!'
  }

  console:inspect &icon=🧬 'Injecting the requested pnpm version' $pnpm-version

  jq '.packageManager = "pnpm@'$pnpm-version'"' package.json | slurp > package.json
}

fn -try-to-display-package-json { |target|
  if (os:is-regular package.json) {
    echo "📦Generated package.json descriptor for the '"$target"' target:"
    jq -C . package.json
  } else {
    echo "💭No package.json descriptor generated for the '"$target"' target..."
  }
}

fn generate-target { |inputs|
  console:inspect &icon=📥 "Inputs" (pprint $inputs)

  -generate-target-via-wasm-pack $inputs

  tmp pwd = $inputs[target-directory]

  if (not-eq $inputs[nodejs-version] '') {
    -inject-nodejs-version $inputs[nodejs-version]
  }

  if (not-eq $inputs[pnpm-version] '') {
    -inject-pnpm-version $inputs[pnpm-version]
  }

  -try-to-display-package-json $inputs[target]

  console:inspect &icon=✅ 'WebAssembly target ready in' $inputs[target-directory]
}