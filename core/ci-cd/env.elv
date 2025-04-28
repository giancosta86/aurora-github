use ./io

fn write { |key value|
  io:write (get-env GITHUB_ENV) $key $value
}

fn map { |source-map|
  io:map (get-env GITHUB_ENV) $source-map
}