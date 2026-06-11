use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ./out-shared

fn write { |key value|
  set-env $key $value
  out-shared:write (get-env GITHUB_ENV) $key $value
}

fn map { |@arguments|
  var source-map = (lang:get-single-input $arguments)

  map:iterate $source-map { |key value|
    set-env $key $value
  }

  out-shared:map (get-env GITHUB_ENV) $source-map
}