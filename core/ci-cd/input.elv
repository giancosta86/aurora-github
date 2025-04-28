use os
use path
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/seq

fn string { |&optional=$false name value|
  var trimmed-value = (str:trim-space $value)

  if (seq:is-empty $trimmed-value) {
    if $optional {
      put $nil
      return
    } else {
      fail 'Missing input: '''$name'''!'
    }
  }

  put $trimmed-value
}

fn -parse-string { |&optional=$false name value parser|
  var source-string = (string &optional=$optional $name $value)
  if (not $source-string) {
    put $nil
    return
  }

  $parser $source-string
}

fn bool { |&optional=$false name value|
  -parse-string &optional=$optional $name $value { |source-string|
    if (==s $source-string true) {
      put $true
    } elif (==s $source-string false) {
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
    var clean-path = (path:clean $source-string)

    if ($path-checker $clean-path) {
      put $clean-path
    } else {
      if $can-be-missing {
        console:inspect &emoji=💭 'Missing '$type-description' for input '''$name''' at path' $clean-path
        put $nil
      } else {
        fail 'Inexistent '$type-description' for input '''$name''' at path: '''$clean-path'''!'
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

fn list { |source|
  put [(
    str:split , $source |
      each $str:trim-space~ |
      keep-if $seq:is-non-empty~
  )]
}