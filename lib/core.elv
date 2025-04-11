use str
use re

fn ternary { |condition when-true when-false|
  if $condition {
    put $when-true
  } else {
    put $when-false
  }
}

fn write-env { |key value|
  echo $key'='$value >> $E:GITHUB_ENV
}

fn write-output { |key value|
  echo $key'='$value >> $E:GITHUB_OUTPUT
}

fn map-to-env { |source-map|
  keys $source-map | each { |key|
    write-env $key $source-map[$key]
  }
}

fn map-to-output { |source-map|
  keys $source-map | each { |key|
    write-output $key $source-map[$key]
  }
}

fn parse-string-list { |string-list|
  re:split ',| ' $string-list |
    keep-if { |entry| not-eq $entry "" }
}

fn string-list-to-csv { |csv-list|
  parse-string-list $csv-list | str:join ,
}

fn to-sha { |source|
  echo $source |
    sha256sum |
    str:split ' ' (all) |
    take 1
}

fn validate-input { |name value|
  if (eq $value "") {
    echo "❌Missing action input: '"$name"'!" >&2
    exit 1
  }

  echo $value
}

fn first-or-nil { |source|
  ternary (eq (count $source) 1) $source[0] $nil
}

fn get-or-else { |map key default|
  ternary (has-key map key) map[key] $default
}
