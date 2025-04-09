use os
use path
use re
use ./console
use ./core

var -snippet-pattern = '(?s)```rust\s*(.*?)\s*```'

var -test-bootstrap-code = '

#[test]
fn run_code_snippet() {
    main().unwrap();
}'

fn -check-markdown-file { |markdown-path optional|
  if (os:is-regular $markdown-path) {
    console:inspect &emoji=🗒️ 'Source markdown found' $markdown-path
    return
  }

  if $optional {
    echo 💭$markdown-path not found - cannot extract snippets
    exit
  }

  fail "Missing source Markdown file: '"$markdown-path"'"
}


fn -extract-snippets-to-files { |markdown-path test-filename-prefix|
  var test-directory = (path:dir $test-filename-prefix)
  console:inspect &emoji=📁 'Ensuring test directory' $test-directory
  os:mkdir-all $test-directory
  echo ✅Test directory ready!

  var generated-test-paths = []

  echo 🔁Trying to extract tests from Rust snippets in Markdown..

  slurp < $markdown-path | re:find $-snippet-pattern (all) | core:enumerate { |index match|
    var snippet = $match[groups][1][text]

    var updated-snippet = $snippet''$-test-bootstrap-code

    var snippet-path = $test-filename-prefix(+ $index 1)'.rs'

    echo $updated-snippet > $snippet-path
  }

  if (core:not-empty $generated-test-paths) {
    console:print-block &emoji=🎩 'Process completed! Generated test files' {
      for test-path $generated-test-paths {
        echo $test-path
      }
    }
  } else {
      echo 💭No snippets found in the source Markdown file...
  }
}


fn extract { |inputs|
  console:inspect-inputs $inputs

  var markdown-path = $inputs[markdown-path]
  var optional = (core:parse-bool $inputs[optional])
  var test-filename-prefix = $inputs[test-filename-prefix]

  -check-markdown-file $markdown-path $optional

  -extract-snippets-to-files $markdown-path $test-filename-prefix
}