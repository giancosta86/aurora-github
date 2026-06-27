fn section { |&emoji=🔎 description block|
  echo $emoji $description':'

  $block

  echo (repeat 3 $emoji)
}

fn inspect { |&emoji=🔎 description value|
  if (eq (kind-of $value) string) {
    echo $emoji $description": '"$value"'"
  } else {
    echo $emoji $description':'
    pprint $value
  }
}