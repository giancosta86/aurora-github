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
    core:ternary (core:parse-bool $inputs[development]) '--dev' '--release'
  )

  var npm-scope-args = (
    core:ternary (core:not-empty $inputs[npm-scope]) ['--scope' $inputs[npm-scope]] []
  )

  wasm-pack build --target $inputs[target] $mode-arg $@npm-scope-args --out-dir $inputs[target-directory]
}

fn -inject-nodejs-version { |nodejs-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested NodeJS version!'
  }

  console:inspect &emoji=🧬 'Injecting the requested NodeJS version' $nodejs-version

  core:jq-edit package.json '.engines.node = "'$nodejs-version'"'
}

fn -inject-pnpm-version { |pnpm-version|
  if (not (os:is-regular package.json)) {
    fail 'package.json was not generated for this target - cannot inject the requested pnpm version!'
  }

  console:inspect &emoji=🧬 'Injecting the requested pnpm version' $pnpm-version

  core:jq-edit package.json '.packageManager = "pnpm@'$pnpm-version'"'
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
  console:inspect-inputs $inputs

  -generate-target-via-wasm-pack $inputs

  tmp pwd = $inputs[target-directory]

  if (core:not-empty $inputs[nodejs-version]) {
    -inject-nodejs-version $inputs[nodejs-version]
  }

  if (core:not-empty $inputs[pnpm-version]) {
    -inject-pnpm-version $inputs[pnpm-version]
  }

  -try-to-display-package-json $inputs[target]

  console:inspect &emoji=✅ 'WebAssembly target ready in' $inputs[target-directory]
}