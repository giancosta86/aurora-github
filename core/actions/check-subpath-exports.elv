use os
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ../std-err

var check-json-value~

fn check-json-object { |path-in-json json-object|
  keys $json-object | order | each { |key|
    check-json-value $path-in-json'->'$key $json-object[$key]
  }
}

fn check-file-pattern { |path-in-json file-pattern|
  print 🔎 $path-in-json'->'$file-pattern...' '

  var matches = (find . -wholename $file-pattern | wc -l)

  if (== $matches 0) {
    echo ❌
    fail 'No file matching subpath pattern: '$file-pattern
  } else {
    echo ✅
  }
}

set check-json-value~ = { |path-in-json json-value|
  var checker = (
    lang:ternary (==s (kind-of $json-value) map) $check-json-object~ $check-file-pattern~
  )

  $checker $path-in-json $json-value
}

fn main {
  if (not (os:is-regular package.json)) {
    fail 'The package.json descriptor file does not exist!'
  }

  var exports = (
    from-json < package.json |
      map:get-value (all) exports
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