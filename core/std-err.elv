use builtin

fn redirect { |block|
  $block |
    only-bytes
}

fn echo { |@arguments|
  builtin:echo $@arguments
}

fn section { |&emoji=🔎 description block|
  redirect {
    builtin:echo $emoji $description':'

    $block

    builtin:echo (repeat 3 $emoji)
  }
}

fn inspect { |&emoji=🔎 description value|
  redirect {
    if (eq (kind-of $value) string) {
      builtin:echo $emoji $description": '"$value"'"
    } else {
      builtin:echo $emoji $description':'
      pprint $value
    }
  }
}