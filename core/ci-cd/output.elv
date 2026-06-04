use github.com/giancosta86/ethereal/v1/lang
use ./out-shared

fn write { |key value|
  out-shared:write (get-env GITHUB_OUTPUT) $key $value
}

fn map { |@arguments|
  var source-map = (lang:get-single-input $arguments)

  out-shared:map (get-env GITHUB_OUTPUT) $source-map
}