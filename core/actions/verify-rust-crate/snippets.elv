use os
use re
use str
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/seq

var -snippet-pattern = '(?s)```rust\s+(.*?)```'

fn extract { |markdown-path test-filename-prefix|
  if (not (os:is-regular $markdown-path)) {
    echo 💭 Source markdown path not found - cannot extract snippets
    return
  }

  console:inspect &emoji=🗒️ 'Source markdown found' $markdown-path

  echo 🎩 Trying to extract tests from Rust snippets in Markdown...

  var generated-test-paths = (
    slurp < $markdown-path |
      re:find $-snippet-pattern (all) |
      seq:enumerate |
      seq:reduce [] { |cumulated index-match-pair|
        var index match = (all $index-match-pair)

        var snippet = (str:trim-space $match[groups][1][text])

        var ordinal = (+ $index 1)

        var snippet-path = $test-filename-prefix''$ordinal'.rs'

        var test-bootstrap-code = (
          str:join "\n" [
            '#[test]'
            'fn run_code_snippet_'$ordinal'() {'
            '    main().unwrap();'
            '}'
          ]
        )

        var updated-snippet = $snippet"\n\n"$test-bootstrap-code"\n"

        fs:save-anywhere $snippet-path $updated-snippet

        conj $cumulated $snippet-path
      }
  )

  if (seq:is-non-empty $generated-test-paths) {
    console:section &emoji=🪄 'Process completed! Generated test files' {
      all $generated-test-paths | each { |test-path|
        echo 📄 $test-path
      }
    }
  } else {
      echo 💭 No snippets found in the source Markdown file...
  }
}