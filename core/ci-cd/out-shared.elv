use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map

var -constant-mappings = [
  &$nil=''
  &$true='true'
  &$false='false'
]

fn -format-value { |value|
  var mapped-value = (lang:get-value $-constant-mappings $value)

  if $mapped-value {
    put $mapped-value
  } else {
    to-string $value
  }
}

fn write { |target-channel key value|
  echo $key'='(-format-value $value) >> $target-channel
}

fn map { |target-channel source-map|
  map:iterate $source-map { |key value|
    write $target-channel $key $value
  }
}