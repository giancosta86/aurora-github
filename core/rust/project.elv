use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/edit


fn document-all-features {
  edit:file Cargo.toml { |content|
    var docs-header = '[package.metadata.docs.rs]'

    if (str:contains $content $docs-header) {
      console:echo 💬 Skipping documentation addendum because $docs-header already appears in Cargo.toml...

      put $nil
    } else {
      console:echo 📚 Now adding the "'"all-features = true"'" documentation addendum to the project descriptor!

      var descriptor-addendum = (str:join "\n" [
        $docs-header
        'all-features = true'
      ])

      put (str:trim-space $content)"\n\n"$descriptor-addendum
    }
  }
}