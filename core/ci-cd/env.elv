use os
use path
use str
use ./out-shared

fn write { |key value|
  out-shared:write (get-env GITHUB_ENV) $key $value
}

fn map { |source-map|
  out-shared:map (get-env GITHUB_ENV) $source-map
}

fn get-value { |&optional=$false key|
  if (has-env $key) {
    get-env $key
  } else {
    if $optional {
      put $nil
    } else {
      fail 'Missing env key: '$key
    }
  }
}

fn -file-system-input { |&optional=$false &can-be-missing=$false type-description key path-checker|
  var value = (get-value &optional=$optional $key)

  if $value {
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
  } else {
    put $nil
  }
}

fn directory { |&optional=$false &can-be-missing=$false name|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing directory $name $os:is-dir~
}

fn file { |&optional=$false &can-be-missing=$false name|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing file $name $os:is-regular~
}