use path
use str
use github.com/giancosta86/gauntlet/v1/env

echo 🎭 Initializing the test environment...

get-env GITHUB_WORKSPACE |
  path:join (all) tests npm-package |
  cd (all)

var expected-node-version = (
  from-json < package.json |
    put (all)[engines][node]
)
echo 🎡 Expected NodeJS version: $expected-node-version

var expected-pnpm-version = (
  from-json < package.json |
    put (all)[packageManager] |
    str:split @ (all) |
    drop 1
)
echo 📦 Expected pnpm version: $expected-pnpm-version

env:map [
  &expected-node-version=$expected-node-version
  &expected-pnpm-version=$expected-pnpm-version
]