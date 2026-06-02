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
  -parse-value &optional=$optional $name $value { |source-string|
    if (not (has-value $admissible-list $source-string)) {
      fail 'Invalid enum value for the '''$name''' input: '''$source-string'''!'
    }

    put $source-string
  }
}

fn comma-separated { |source|
  str:split , $source |
    each $str:trim-space~ |
    keep-if $seq:is-non-empty~
}