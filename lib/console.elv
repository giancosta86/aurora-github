use str

fn print { |@rest|
  echo $@rest >&2
}

fn inspect { |&emoji=🔎 &quote=$true description value|
  if $quote {
    print $emoji''$description": '"$value"'"
  } else {
    print $emoji''$description": "$value
  }
}

fn print-block { |&emoji=🔎 description text-or-block|
  print $emoji''$description":"

  if (kind-of $text-or-block | eq "fn") {
    $text-or-block
  } else {
    print $text-or-block
  }

  print (str:repeat $emoji 3)
}

fn is-tracing-enabled {
  eq $E:AURORA_GITHUB_ENABLE_TRACING true
}

fn trace { |@rest|
  if (is-tracing-enabled) {
    print $@rest
  }
}

fn inspect-trace { |&emoji=🔎 &quote=$true description value|
  if (is-tracing-enabled) {
    inspect &emoji=$emoji &quote=$quote $description $value
  }
}