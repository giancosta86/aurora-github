use builtin

fn capture { |block|
  $block |
    only-bytes >&2
}

fn echo { |@arguments|
  builtin:echo $@arguments >&2
}

fn section { |&emoji=📜 description block|
  capture {
    builtin:echo $emoji $description':'

    $block

    builtin:echo (repeat 3 $emoji)
  }
}

fn inspect { |&emoji=🔎 description value|
  capture {
    if (eq (kind-of $value) string) {
      builtin:echo $emoji $description": '"$value"'"
    } else {
      builtin:echo $emoji $description':'
      pprint $value
    }
  }
}