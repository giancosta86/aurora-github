use ./lang
use ./seq
use ./bool

fn require { |name value|
  if (seq:is-empty $value) {
    fail "❌Missing action input: '"$name"'!"
  }

  put $value
}

fn require-bool { |name value|
  var declared-value = (require $name $value)

  bool:parse $declared-value
}

fn list { |value|
  put [(seq:split-csv $value)]
}

fn optional { |value|
  lang:ternary (!=s $value '') $value $nil
}

fn require-enum { |name value admissible-list|
  var value = (require $name $value)

  if (not (has-value $admissible-list $value)) {
    fail "Invalid value for the '"$name"' input: '"$value"'"
  }

  put $value
}