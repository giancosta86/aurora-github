use ./out-shared

fn write { |key value|
  out-shared:write (get-env GITHUB_ENV) $key $value
}

fn map { |source-map|
  out-shared:map (get-env GITHUB_ENV) $source-map
}