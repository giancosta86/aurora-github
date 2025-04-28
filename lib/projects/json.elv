fn read-version { |descriptor-path|
  put (cat $descriptor-path | from-json)[version]
}

fn print-descriptor { |descriptor-path|
  jq -C . $descriptor-path
}