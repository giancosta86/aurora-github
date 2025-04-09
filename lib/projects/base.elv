use builtin
use path
use ../console
use ../core
use ./plain-text

fn load-project { |inputs|
  var directory = $inputs[directory]
  var descriptor-name = $inputs[descriptor-name]
  var technology = $inputs[technology]
  var build-tool = $inputs[build-tool]
  var emoji = $inputs[emoji]
  var version-reader = $inputs[version-reader]
  var descriptor-printer = (core:get-value $inputs descriptor-printer &default=$plain-text:print-descriptor~)

  var descriptor-path = (path:join $directory $descriptor-name)

  put [
    &directory=$directory

    &descriptor-path=$descriptor-path

    &descriptor-name=$descriptor-name

    &technology=$technology

    &build-tool=$build-tool

    &emoji=$emoji

    &read-version={ $version-reader $descriptor-path }

    &print-descriptor={
       console:print-block &emoji=$emoji 'Project descriptor' {
         $descriptor-printer $descriptor-path
       }
    }

    &to-string={ put $emoji''$technology' ('$descriptor-name')' }
  ]
}
