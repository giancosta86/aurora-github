use os
use re
use str
use github.com/giancosta86/aurora-elvish/fs
use github.com/giancosta86/aurora-elvish/seq
use ../../std-err

var -snippet-pattern = '(?s)```rust\s+(.*?)```'

fn -get-test-bootstrap-code { |ordinal|
  str:join "\n" [
    '#[test]'
    'fn run_code_snippet_'$ordinal'() {'
    '    main().unwrap();'
    '}'
  ]
}

fn extract { |markdown-path test-filename-prefix|
  if (not (os:is-regular $markdown-path)) {
    std-err:echo 💭 Source markdown path not found - cannot extract snippets
    return
  }

  std-err:inspect &emoji=🗒️ 'Source markdown found' $markdown-path

  var generated-test-paths = []

  std-err:echo 🎩 Trying to extract tests from Rust snippets in Markdown...

  slurp < $markdown-path |
    re:find $-snippet-pattern (all) |
    seq:enumerate { |index match|
      var snippet = (str:trim-space $match[groups][1][text])

      var ordinal = (+ $index 1)

      var snippet-path = $test-filename-prefix''$ordinal'.rs'

      var test-bootstrap-code = (-get-test-bootstrap-code $ordinal)

      var updated-snippet = $snippet"\n\n"$test-bootstrap-code

      fs:save-anywhere $snippet-path $updated-snippet

      set generated-test-paths = (conj $generated-test-paths $snippet-path)
    }

  if (seq:is-non-empty $generated-test-paths) {
    std-err:section &emoji=🎩 'Process completed! Generated test files' {
      all $generated-test-paths | each { |test-path|
        std-err:echo 📄 $test-path
      }
    }
  } else {
      std-err:echo 💭 No snippets found in the source Markdown file...
  }
}