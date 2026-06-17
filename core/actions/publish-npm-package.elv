use os
use github.com/giancosta86/astral-bridge/v1/package-manager
use github.com/giancosta86/ethereal/v1/lang
use ../highlight
use ../std-err
use ./input

fn ensure-npm-config {
  var config-path = .npmrc

  if (os:is-regular $config-path) {
    echo 🌟You already have a custom $config-path file!
    return
  }

  echo 🧞 It seems you do not have a $config-path file - generating a default one...

  echo '//registry.npmjs.org/:_authToken=${NPM_TOKEN}' > $config-path

  std-err:section &emoji=🎀 'Your auto-generated '$config-path' configuration file' {
    highlight:file $config-path ini
  }
}

fn publish-to-registry { |dry-run|
  var dry-run-arg = (lang:ternary $dry-run [--dry-run] [])

  npm publish --access public $@dry-run-arg
}

fn main {
  var dry-run = (input:bool dry-run)

  package-manager:exec build

  std-err:section &emoji=📦 'package.json just before publication' {
    highlight:file package.json json
  }

  ensure-npm-config

  publish-to-registry $dry-run

  echo ✅📦 npm package publication successful!
}