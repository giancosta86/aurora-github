use os
use str
use github.com/giancosta86/ethereal/v1/lang
use ../std-err

var check-json-value~

fn check-json-object { |path-in-json json-object|
  keys $json-object |
    order |
    each { |key|
      check-json-value $path-in-json'->'$key $json-object[$key]
    }
}

fn check-file-pattern { |path-in-json file-pattern|
  print 🔎 $path-in-json'->'$file-pattern...' '

  var files-found = (
    if (str:contains $file-pattern '*') {
      var parent-dir = (
        str:split '*' $file-pattern |
        take 1
      )
      os:is-dir $parent-dir
    } else {
      os:is-regular $file-pattern
    }
  )

  if $files-found {
    echo ✅
  } else {
    echo ❌
    fail 'No file matching subpath pattern: '$file-pattern
  }
}

set check-json-value~ = { |path-in-json json-value|
  var checker = (
    ==s (kind-of $json-value) map |
      lang:ternary (all) $check-json-object~ $check-file-pattern~
  )

  $checker $path-in-json $json-value
}

fn main {
  if (not (os:is-regular package.json)) {
    fail 'The package.json descriptor file does not exist!'
  }

  var exports = (
    from-json < package.json |
      lang:get-value (all) exports
  )

  if (not $exports) {
    echo 💭 No exports declared in package.json...
    return
  }

  if (== (count $exports) 0) {
    echo 💭 Exports are an empty object...
    return
  }

  echo 🔎 Now inspecting subpath exports...

  check-json-value exports $exports

  echo ✅ Export subpaths are OK!
}