use os
use ../core

var -recursive-check-json-value

fn -check-json-object { |path-in-json json-object|
  keys $json-object | to-lines | sort | each { |key|
    $-recursive-check-json-value $path-in-json'->'$key $json-object[$key]
  }
}

fn -check-file-pattern { |path-in-json file-pattern|
  print 🔎 $path-in-json'->'$file-pattern...' '

  var matches = (find . -wholename $file-pattern | wc -l)

  if (==s $matches 0) {
    echo ❌
    fail 'No file matching subpath pattern: '$file-pattern
  } else {
    echo ✅
  }
}

fn -check-json-value { |path-in-json json-value|
  var actual-checker = (
    core:ternary (==s (kind-of $json-value) map) $-check-json-object~ $-check-file-pattern~
  )

  $actual-checker $path-in-json $json-value
}

set -recursive-check-json-value = $-check-json-value~

fn check {
  if (not (os:is-regular package.json)) {
    fail 'The package.json descriptor file does not exist!'
  }

  var exports = (core:get-value (from-json < package.json) exports)

  if (is $exports $nil) {
    echo 💭No exports declared in package.json...
    return
  }

  echo 🔎 Now inspecting subpath exports...

  -check-json-value exports $exports

  echo ✅Export subpaths are OK!
}