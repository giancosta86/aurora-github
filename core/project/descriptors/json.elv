use ../../highlighting

fn read-version { |descriptor-path|
  put (from-json < $descriptor-path)[version]
}

fn print-content { |descriptor-path|
  cat $descriptor-path | highlighting:highlight json
}