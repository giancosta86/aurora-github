use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/gauntlet/v1/repository

cd (repository:get-path tests npm-package)

get-env jq-operation |
  jq (all) package.json > package.tmp

mv package.tmp package.json

console:section &emoji=🔎 'The "exports" field is' {
  jq -C '.exports' package.json
}