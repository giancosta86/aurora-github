fn read-version { |descriptor-path|
  put (slurp < $descriptor-path | from-json)[version]
}

fn print-descriptor { |descriptor-path|
  jq -C . $descriptor-path
}