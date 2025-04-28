use str

fn is-empty { |container| == (count $container) 0 }

fn is-non-empty { |container| != (count $container) 0 }

fn first-or-default { |source &default=$nil|
  if (== (count $source) 1) {
    put $source[0]
  } else {
    put $default
  }
}

fn enumerate { |@inputs|
  var input-count = (count $inputs)

  if (== $input-count 1) {
    var index = 0
    var consumer = $inputs[0]

    all | each { |item|
      $consumer $index $item
      set index = (+ $index 1)
    }
  } elif (== $input-count 2) {
    var sequence = $inputs[0]
    var consumer = $inputs[1]

    range 0 (count $sequence) | each { |index|
      $consumer $index $sequence[$index]
    }
  } else {
    fail 'Invalid arity! 1 or 2 arguments expected!'
  }
}

fn split-csv { |source-string|
  str:split , $source-string |
    each { |entry| str:trim-space $entry } |
    keep-if { |entry| is-non-empty $entry }
}

fn to-csv { |source|
  str:join , $source
}

