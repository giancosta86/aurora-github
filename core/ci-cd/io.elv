use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/map
use github.com/giancosta86/aurora-elvish/seq

var -constant-mappings = [
  &$nil=''
  &$true='true'
  &$false='false'
]

var -supported-value-kinds = [string number]

fn -format-value { |value|
  var mapped-value = (map:get-value $-constant-mappings $value)

  coalesce $mapped-value $value
}

fn write { |target-channel key value|
  echo $key'='(-format-value $value) >> $target-channel
}

fn map { |target-channel source-map|
  map:entries $source-map |
    seq:each-spread { |key value|
      var value-kind = (kind-of $value)

      if (has-value $-supported-value-kinds $value-kind) {
        write $target-channel $key $value
      }
    }
}