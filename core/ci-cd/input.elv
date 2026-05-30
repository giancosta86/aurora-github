use os
use path
use str

use github.com/giancosta86/ethereal/v1/seq

fn string { |&optional=$false name value|
  var trimmed-value = (
    str:trim-space $value |
      seq:empty-to-default
  )

  if (
    and (eq $trimmed-value $nil) (not $optional)
  ) {
    fail 'Missing input: '''$name'''!'
  }

  put $trimmed-value
}

fn -parse-value { |&optional=$false name value parser|
  var source-string = (
    string &optional=$optional $name $value
  )

  if $source-string {
    $parser $source-string
  } else {
    put $nil
  }
}

fn bool { |&optional=$false name value|
  -parse-value &optional=$optional $name $value { |source-string|
    if (eq $source-string true) {
      put $true
    } elif (eq $source-string false) {
      put $false
    } else {
      fail 'Invalid boolean value for the '''$name''' input: '''$source-string'''!'
    }
  }
}

fn enum { |&optional=$false name value admissible-list|
  -parse-string &optional=$optional $name $value { |source-string|
    if (not (has-value $admissible-list $source-string)) {
      fail 'Invalid enum value for the '''$name''' input: '''$source-string'''!'
    }

    put $source-string
  }
}

fn -file-system-input { |&optional=$false &can-be-missing=$false type-description name value path-checker|
  -parse-string &optional=$optional $name $value { |source-string|
    var abs-path = (path:abs $source-string)

    if ($path-checker $abs-path) {
      put $abs-path
    } else {
      if $can-be-missing {
        put $nil
      } else {
        fail 'Inexistent '$type-description' for input '''$name''' at path: '''$abs-path'''!'
      }
    }
  }
}

fn directory { |&optional=$false &can-be-missing=$false name value|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing directory $name $value $os:is-dir~
}

fn file { |&optional=$false &can-be-missing=$false name value|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing file $name $value $os:is-regular~
}

fn comma-separated { |source|
  str:split , $source |
    each $str:trim-space~ |
    keep-if $seq:is-non-empty~
}