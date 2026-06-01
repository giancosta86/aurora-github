use ./out-shared

fn write { |key value|
  out-shared:write (get-env GITHUB_OUTPUT) $key $value
}

fn map { |source-map|
  out-shared:map (get-env GITHUB_OUTPUT) $source-map
}