use path
use github.com/giancosta86/aurora-elvish/map
use ./descriptors/plain-text

fn load-project { |inputs|
  var descriptor-namespace = $inputs[descriptor-namespace]
  var descriptor-name = $inputs[descriptor-name]
  var technology = $inputs[technology]
  var build-tool = $inputs[build-tool]
  var emoji = $inputs[emoji]

  var descriptor-path = (path:join $pwd $descriptor-name)

  put [
    &directory=$pwd

    &descriptor-path=$descriptor-path

    &descriptor-name=$descriptor-name

    &technology=$technology

    &build-tool=$build-tool

    &emoji=$emoji

    &read-version={ $descriptor-namespace[read-version~] $descriptor-path }

    &print-descriptor={
      echo $emoji 'Project descriptor ('$descriptor-name')'
      $descriptor-namespace[print-content~] $descriptor-path
      echo (repeat 3 $emoji)
    }

    &to-string={ put $emoji' '$technology' ('$descriptor-name')' }
  ]
}
