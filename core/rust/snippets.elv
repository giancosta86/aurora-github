use os
use path
use re
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/seq

var -snippet-pattern = '(?s)```rust\s+(.*?)```'

fn -get-test-bootstrap-code { |ordinal|
  str:join "\n" [
    '#[test]'
    'fn run_code_snippet_'$ordinal'() {'
    '    main().unwrap();'
    '}'
  ]
}

fn -ensure-test-directory { |snippet-path|
  var test-directory = (path:dir $snippet-path)

  if (not (os:is-dir $test-directory)) {
    console:inspect &emoji=📁 'Creating test directory' $test-directory
    os:mkdir-all $test-directory
    console:echo ✅ Test directory ready!
  }
}

fn -extract-snippets-to-files { |markdown-path test-filename-prefix|
  var test-directory = (path:dir $test-filename-prefix)
  var generated-test-paths = []

  console:echo 🎩 Trying to extract tests from Rust snippets in Markdown...

  slurp < $markdown-path | re:find $-snippet-pattern (all) | seq:enumerate { |index match|
    var snippet = (str:trim-space $match[groups][1][text])

    var ordinal = (+ $index 1)

    var test-bootstrap-code = (-get-test-bootstrap-code $ordinal)

    var updated-snippet = $snippet"\n\n"$test-bootstrap-code

    var snippet-path = $test-filename-prefix''$ordinal'.rs'

    -ensure-test-directory $snippet-path

    echo $updated-snippet > $snippet-path

    set generated-test-paths = (conj $generated-test-paths $snippet-path)
  }

  if (seq:is-non-empty $generated-test-paths) {
    console:section &emoji=🎩 'Process completed! Generated test files' {
      for test-path $generated-test-paths {
        console:echo 📄 $test-path
      }
    }
  } else {
      console:echo 💭 No snippets found in the source Markdown file...
  }
}

fn extract { |inputs|
  console:inspect-inputs $inputs

  var markdown-path = $inputs[markdown-path]
  var optional = $inputs[optional]
  var test-filename-prefix = $inputs[test-filename-prefix]

  if $markdown-path {
    console:inspect &emoji=🗒️ 'Source markdown found' $markdown-path

    -extract-snippets-to-files $markdown-path $test-filename-prefix
  } else {
    if $optional {
      console:echo 💭 Source markdown path not found - cannot extract snippets
    } else {
      fail 'Missing source Markdown file!'
    }
  }
}