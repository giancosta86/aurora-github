use os
use path
use str
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/seq

fn string { |&optional=$false name|
  if (has-env $name) {
    get-env $name |
      str:trim-space (all)
  } else {
    if $optional {
      put $nil
    } else {
      fail 'Missing input: '$name
    }
  }
}

fn -parse { |&optional=$false name parser|
  string &optional=$optional $name |
    lang:map { |value|
      $parser $value
    }
}

fn bool { |&optional=$false name|
  -parse &optional=$optional $name { |value|
    if (eq $value true) {
      put $true
    } elif (eq $value false) {
      put $false
    } else {
      fail 'Invalid boolean value for the '''$name''' input: '''$value'''!'
    }
  }
}

fn enum { |&optional=$false name admissible-list|
  -parse &optional=$optional $name { |value|
    if (not (has-value $admissible-list $value)) {
      fail 'Invalid enum value for the '''$name''' input: '''$value'''!'
    }

    put $value
  }
}

fn tokenized { |&optional=$false &separator=, name|
  -parse &optional=$optional { |value|
    str:split $separator $value |
      each $str:trim-space~ |
      keep-if $seq:is-non-empty~
  }
}

fn -file-system-input { |&optional=$false &can-be-missing=$false type-description key path-checker|
  -parse &optional=$optional { |value|
    var abs-path = (
      path:abs $value
    )

    if ($path-checker $abs-path) {
      put $abs-path
    } else {
      if $can-be-missing {
        put $nil
      } else {
        fail 'Inexistent '$type-description' for env key '''$key''' at path: '''$abs-path'''!'
      }
    }
  }
}

fn directory { |&optional=$false &can-be-missing=$false name|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing directory $name $os:is-dir~
}

fn file { |&optional=$false &can-be-missing=$false name|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing file $name $os:is-regular~
}