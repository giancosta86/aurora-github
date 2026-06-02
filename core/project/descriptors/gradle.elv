use path
use github.com/giancosta86/ethereal/v1/lang
use ../../highlighting
use ./toml

var read-version~ = $toml:read-version~

fn print-content { |descriptor-path|
  var extension = (path:ext $descriptor-path)

  var highlighting-format = (lang:ternary (eq $extension .kts) kotlin groovy)

  cat $descriptor-path | highlighting:highlight $highlighting-format
}