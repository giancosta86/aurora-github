use path
use github.com/giancosta86/aurora-elvish/highlighting
use github.com/giancosta86/aurora-elvish/lang
use ./toml

var read-version~ = $toml:read-version~

fn print-content { |descriptor-path|
  var extension = (path:ext $descriptor-path)

  var highlighting-format = (lang:ternary (==s $extension .kts) kotlin groovy)

  cat $descriptor-path | highlighting:highlight $highlighting-format
}