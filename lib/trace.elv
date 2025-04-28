use builtin
use ./bool
use ./console

fn is-enabled {
  bool:parse (get-env AURORA_TRACING_ENABLED)
}

fn echo { |@rest|
  if (is-enabled) {
    builtin:echo $@rest
  }
}

fn inspect { |&emoji=🔎 description value|
  if (is-enabled) {
    console:inspect &emoji=$emoji $description $value
  }
}