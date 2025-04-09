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

    &icon=$inputs[icon]

    &descriptor-name=$inputs[descriptor-name]

    &descriptor-path=$descriptor-path

    &read-version={
      $inputs[read-version] $descriptor-path
    }

    &build-tool=$inputs[build-tool]

    &as-string=$inputs[icon]$inputs[technology]($inputs[descriptor-name])

    &print-descriptor={
      console:print-block &icon=$inputs[icon] 'Project descriptor' {
        $descriptor-printer $descriptor-path
      }
    }
  ]
}
