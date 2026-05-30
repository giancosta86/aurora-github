use github.com/giancosta86/ethereal/lang
use github.com/giancosta86/ethereal/map

var -constant-mappings = [
  &$nil=''
  &$true='true'
  &$false='false'
]

fn -format-value { |value|
  var mapped-value = (lang:get-value $-constant-mappings $value)

  coalesce $mapped-value $value
}

fn write { |target-channel key value|
  echo $key'='(-format-value $value) >> $target-channel
}

fn map { |target-channel source-map|
  map:iterate { |key value|
    write $target-channel $key $value
  }
}