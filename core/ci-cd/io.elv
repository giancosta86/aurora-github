use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map

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
  map:iterate $source-map { |key value|
    echo Key is: $key

    echo Value is:
    pprint $value

    write $target-channel $key $value
  }
}