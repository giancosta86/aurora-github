use builtin
use path
use ../console
use ../core

fn load-project { |inputs|
  var descriptor-path = (path:join $inputs[directory] $inputs[descriptor-name])
  var descriptor-printer = (core:get-or-else $inputs descriptor-printer e:cat~)

  put [
    &directory=$inputs[directory]

    &technology=$inputs[technology]

    &emoji=$inputs[emoji]

    &descriptor-name=$inputs[descriptor-name]

    &descriptor-path=$descriptor-path

    &read-version={
      $inputs[version-reader] $descriptor-path
    }

    &build-tool=$inputs[build-tool]

    &to-string=$inputs[emoji]$inputs[technology]($inputs[descriptor-name])

    &print-descriptor={
      console:print-block &emoji=$inputs[emoji] 'Project descriptor' {
        $descriptor-printer $descriptor-path
      }
    }
  ]
}
