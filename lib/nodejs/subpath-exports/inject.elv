use os
use path
use str
use ../../console
use ../../files

var -supported-modes = [prefer-index all]
var -index-names = [index.ts index.js]

fn -print-exports { |time-description|
  console:section &emoji=📦 'package.json exports '$time-description {
    jq -C .exports package.json
  }
}

fn -write-export { |relative-index-directory|
  var export-key = '.'$relative-index-directory

  var dist-index-directory = './dist'$relative-index-directory

  console:echo "🔑Export '"$export-key"' provided by dist directory: '"$dist-index-directory"'"

  files:jq-edit package.json '
      .exports += {
        "'$export-key'": {
          types: "'$dist-index-directory'/index.d.ts",
          import: "'$dist-index-directory'/index.js"
        }
      }'

  console:echo ✅Export $export-key injected!
}

fn -inject-root-index { |source-directory|
  put $source-directory/{$@-index-names} | each { |potential-root-index|
    console:inspect 'Looking for potential root index' $potential-root-index

    if (os:is-regular $potential-root-index) {
      console:inspect &emoji=✅ 'Root index file found' $potential-root-index

      -write-export ''

      put $true
      return
    }
  }

  console:echo 💭No root index file found...
  put $false
}

fn -inject-second-level-indexes { |source-directory|
  console:inspect 'Looking for potential second-level indexes under' $source-directory
  put $source-directory/*[type:regular][nomatch-ok]/{$@-index-names} | each { |index-path|
    var export-name = (str:trim-prefix (path:dir $index-path) $source-directory/)

    -write-export '/'$export-name
  }
}

fn -do-inject { |source-directory mode|
  var root-index-injected = (-inject-root-index $source-directory)

  if (and $root-index-injected (==s $mode prefer-index)) {
    console:echo 🐹In this mode, since the root index has been found, no more subpath exports will be injected
    return
  }

  -inject-second-level-indexes $source-directory
}

fn inject { | inputs |
  console:inspect-inputs $inputs

  var mode = $inputs[mode]
  var source-directory = (str:trim-right $inputs[source-directory] '/')

  if (not (has-value $-supported-modes $mode)) {
    fail "Invalid mode: '"$mode"'"
  }

  -print-exports 'before the injection'

  -do-inject $source-directory $mode

  -print-exports 'after the injection'
}