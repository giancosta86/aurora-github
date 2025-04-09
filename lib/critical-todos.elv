use str
use ./console
use ./core

fn find { |inputs|
  console:inspect-inputs $inputs
  console:inspect &emoji=📁 'Current directory' $pwd

  var todo-text = "TODO""!"

  if (core:parse-bool $inputs[verbose]) {
    console:print-block &emoji=📄 'File list to filter when looking for TODOs' {
      e:find -type f -print
    }
  }

  var quiet-arg = (core:ternary (core:parse-bool $inputs[display-lines]) '' '-q')

  var found = ?(e:find -type f -print0 | grep -zP $inputs[source-file-regex] | xargs -0 grep --color=always -Hn $@quiet-arg $todo-text)

  if $found {
    if (core:parse-bool $inputs[crash-on-found]) {
      fail 'Critical TODOs found!'
    } else {
      echo ⚠️Critical TODOs found!
    }
  } else {
    echo ✅No critical TODOs found!
  }

  core:write-output found (bool $found | to-string (all) | str:trim-prefix (all) '$')
}

