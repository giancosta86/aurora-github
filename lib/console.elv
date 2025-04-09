use str

fn print { |@rest|
  echo $@rest >&2
}

fn inspect { |&icon=🔎 &quote=$true description value|
  if $quote {
    print $icon''$description": '"$value"'"
  } else {
    print $icon''$description": "$value
  }
}

fn print-block { |&icon=🔎 description text-or-block|
  print $icon''$description":"

  if (kind-of $text-or-block | eq "fn") {
    $text-or-block
  } else {
    print $text-or-block
  }

  print (str:repeat $icon 3)
}

fn is-tracing-enabled {
  eq $E:AURORA_GITHUB_ENABLE_TRACING true
}

fn trace { |@rest|
  if (is-tracing-enabled) {
    print $@rest
  }
}

fn inspect-trace { |&icon=🔎 &quote=$true description value|
  if (is-tracing-enabled) {
    inspect &icon=$icon &quote=$quote $description $value
  }
}