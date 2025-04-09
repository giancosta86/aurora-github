use str
use re

fn empty { |container| == (count $container) 0 }

fn not-empty { |container| != (count $container) 0 }

fn ternary { |condition when-true when-false|
  if $condition {
    put $when-true
  } else {
    put $when-false
  }
}

fn get-value { |map key &default=$nil|
  if (has-key $map $key) {
    put $map[$key]
  } else {
    put $default
  }
}

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
    fail 'Invalid arity!'
  }
}

fn write-env { |key value|
  echo $key'='$value >> $E:GITHUB_ENV
}

fn write-output { |key value|
  echo $key'='$value >> $E:GITHUB_OUTPUT
}

fn map-to-env { |source-map|
  keys $source-map | each { |key|
    write-env $key $source-map[$key]
  }
}

fn map-to-output { |source-map|
  keys $source-map | each { |key|
    write-output $key $source-map[$key]
  }
}

fn parse-string-list { |string-list|
  re:split ',| ' $string-list |
    keep-if { |entry| not-empty $entry }
}

fn string-list-to-csv { |csv-list|
  parse-string-list $csv-list | str:join ,
}

fn to-sha { |source|
  echo $source |
    sha256sum |
    str:split ' ' (all) |
    take 1
}

fn require-input { |name value|
  if (empty $value) {
    echo "❌Missing action input: '"$name"'!" >&2
    exit 1
  }

  echo $value
}

fn edit-file { |path text-transformer|
  var updated-content = (slurp < $path | $text-transformer (all))

  echo $updated-content > $path
}

fn jq-edit { |path jq-operation|
  var updated-json = (jq $jq-operation $path | slurp)
  echo $updated-json > $path
}

fn parse-bool { |string|
  ==s $string true
}

