fn ternary { |condition when-true when-false|
  if $condition {
    put $when-true
  } else {
    put $when-false
  }
}

