use str
use ./console
use ./lang
use ./output

fn find { |inputs|
  console:inspect-inputs $inputs

  var verbose = $inputs[verbose]
  var display-lines = $inputs[display-lines]
  var source-file-regex = $inputs[source-file-regex]
  var crash-on-found = $inputs[crash-on-found]

  console:inspect &emoji=📁 'Current directory' $pwd

  var todo-text = "TODO""!"

  if $verbose {
    console:section &emoji=📄 'File list to filter when looking for TODOs' {
      e:find -type f -print
    }
  }

  var quiet-arg = (lang:ternary $display-lines '' '-q')

  var found = ?(e:find -type f -print0 | grep -zP $source-file-regex | xargs -0 grep --color=always -Hn $@quiet-arg $todo-text)

  if $found {
    if $crash-on-found {
      fail 'Critical TODOs found!'
    } else {
      echo 🤯Critical TODOs found!
    }
  } else {
    echo ✅No critical TODOs found!
  }

  output:write found (bool $found | to-string (all) | str:trim-prefix (all) '$')
}

