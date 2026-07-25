use str
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/edit
use github.com/giancosta86/ethereal/v1/highlight
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/gauntlet/v1/input

fn -document-all-features {
  edit:file Cargo.toml { |content|
    var docs-header = '[package.metadata.docs.rs]'

    if (str:contains $content $docs-header) {
      echo 💬 Skipping documentation addendum because $docs-header already appears in Cargo.toml... >&2

      put $nil
    } else {
      echo 📚 Now adding the documentation addendum to the project descriptor! >&2

      var descriptor-addendum = (str:join "\n" [
        $docs-header
        'all-features = true'
      ])

      str:trim-space $content |
        put (all)"\n\n"$descriptor-addendum
    }
  }
}

fn -publish { |dry-run|
  var dry-run-arg = (lang:ternary $dry-run [--dry-run] [])

  cargo publish --all-features --allow-dirty $@dry-run-arg
}

fn main {
  var document-all-features = (input:bool document-all-features)
  var dry-run = (input:bool dry-run)

  if $document-all-features {
    -document-all-features
  }

  console:section &emoji=🦀 'Cargo.toml just before publication' {
    highlight:file Cargo.toml toml
  }

  -publish $dry-run

  echo ✅🦀 Rust crate publication successful!
}