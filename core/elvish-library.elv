use os
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/string

var -metadata-file = metadata.json

var -required-fields = [
  description
  maintainers
  homepage
  dependencies
]

fn check-metadata {
  if (not (os:is-regular $-metadata-file)) {
    fail 'Missing library metadata file: '$-metadata-file
  }

  var metadata = (from-json < $-metadata-file)

  all $-required-fields | each { |field|
    if (not (has-key $metadata $field)) {
      fail 'Missing required field in '$-metadata-file': '$field
    }
  }

  console:echo ✅ Library metadata OK!
}