fn edit { |path text-transformer|
  var updated-content = (slurp < $path | $text-transformer (all))

  echo $updated-content > $path
}

fn jq-edit { |path jq-operation|
  var updated-json = (jq $jq-operation $path | slurp)
  echo $updated-json > $path
}