use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/edit
use github.com/giancosta86/gauntlet/v1/repository

cd (repository:get-path tests npm-package)

get-env jq-operation |
  edit:json package.json (all)

console:section &emoji=🔎 'The "exports" field is' {
  jq -C '.exports' package.json
}