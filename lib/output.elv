use ./github/io

fn write { |key value|
  io:write (get-env GITHUB_OUTPUT) $key $value
}

fn map { |source-map|
  io:map (get-env GITHUB_OUTPUT) $source-map
}