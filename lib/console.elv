use str
use ./core

fn print { |@rest|
  echo $@rest >&2
}

fn inspect { |&emoji=🔎 &quote=$true description value|
  if $quote {
    print $emoji''$description": '"(to-string $value)"'"
  } else {
    print $emoji''$description": "(to-string $value)
  }
}

fn inspect-inputs { |inputs|
  inspect &emoji=📥 &quote=$false Inputs $inputs
}

fn print-block { |&emoji=🔎 description text-or-block|
  print $emoji''$description":"

  if (==s (kind-of $text-or-block) "fn") {
    $text-or-block | each { |line| print $line }
  } else {
    print $text-or-block
  }

  print (str:repeat $emoji 3)
}

fn is-tracing-enabled {
  core:parse-bool $E:AURORA_GITHUB_ENABLE_TRACING
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