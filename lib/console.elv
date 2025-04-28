use builtin
use str
use ./lang

fn echo { |@rest|
  builtin:echo $@rest > &2
}

var -inspect-formatters = [
  &string={ |source| builtin:echo "'"$source"'" }
  &list={ |source| pprint $source }
  &map={ |source| pprint $source }
]

var -default-inspect-formatter = { |source| echo $source }

fn inspect { |&emoji=🔎 description value|
  print $emoji''$description': ' > &2

  var value-kind = (kind-of $value)

  var formatter

  if (has-key $-inspect-formatters $value-kind) {
    set formatter = $-inspect-formatters[$value-kind]
  } else {
    set formatter = $-default-inspect-formatter
  }

  $formatter $value > &2
}

fn inspect-inputs { |inputs|
  inspect &emoji=📥 Inputs $inputs
}

fn section { |&emoji=🔎 description text-or-block|
  echo $emoji''$description":"

  if (==s (kind-of $text-or-block) "fn") {
    $text-or-block | each { |line| echo $line }
  } else {
    echo $text-or-block
  }

  echo (str:repeat $emoji 3)
}
