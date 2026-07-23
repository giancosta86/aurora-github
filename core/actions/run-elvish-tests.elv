use re
use os
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/seq
use github.com/giancosta86/gauntlet/v1/env
use github.com/giancosta86/gauntlet/v1/input

var verification-script = verify.elv

fn infer-test-strategy {
  var verification-script-exists = (os:is-regular $verification-script)

  var test-strategy = (
    if $verification-script-exists {
      put verification-script
    } else {
      put velvet
    }
  )

  env:set test-strategy $test-strategy
}

fn run-verification-script {
  console:inspect &emoji=📜 'Running verification script' $verification-script

  elvish $verification-script
}

var infer-velvet-version~ = (
  var velvet-version-regex = 'github\.com\/giancosta86\/velvet(?:@(.+))?'

  var default-velvet-version = v4

  fn detect-velvet-version-from-package-reference { |reference|
    echo 📦REFERENCE HERE IS: $reference

    re:find $velvet-version-regex $reference |
      lang:map { |match|
        put $match[groups][1][text] |
          seq:empty-to-default
      }
  }

  fn detect-velvet-version-from-metadata {
    if (not (os:is-regular metadata.json)) {
      put $nil
      return
    }

    var metadata = (from-json < metadata.json)

    all [
      dependencies
      devDependencies
    ] |
      each { |metadata-key|
        var reference-list = (
          lang:get-value &default=[] $metadata $metadata-key
        )

        all $reference-list
      } |
      each { |reference|
        detect-velvet-version-from-package-reference $reference |
          lang:map { |velvet-version|
            put $velvet-version
            return
          }
      }

    put $nil
  }

  put {
    var velvet-version = (
      detect-velvet-version-from-metadata |
        coalesce (all) $default-velvet-version
    )

    console:inspect &emoji=🐞 'Velvet version to run' $velvet-version

    env:set velvet-version $velvet-version
  }
)

fn run-velvet {
  var velvet-version = (get-env velvet-version)

  var velvet-scripts = [(
    input:list velvet-scripts |
      all (all) |
      each { |entry|
        eval 'put '$entry
      }
  )]

  var velvet-module: = (
    use-mod 'github.com/giancosta86/velvet/'$velvet-version'/velvet'
  )

  velvet-module:velvet &flawless $@velvet-scripts
}
