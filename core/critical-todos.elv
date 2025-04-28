use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang

var -todo-text = (printf '%s%s' TODO !)

fn find { |inputs|
  console:inspect-inputs $inputs

  var verbose = $inputs[verbose]
  var display-lines = $inputs[display-lines]
  var source-file-regex = $inputs[source-file-regex]
  var crash-on-found = $inputs[crash-on-found]

  console:inspect &emoji=📁 'Current directory' $pwd

  var quiet-grep-arg = (lang:ternary $display-lines '' '-q')

  var found = $false

  put **[type:regular] |
    keep-if { |path|
      eq $ok ?(echo $path | grep --perl-regexp --quiet $source-file-regex)
    } |
    each { |path|
      if $verbose {
        console:echo 🔎 Looking for critical TODOs in path: $path...
      }

      var found-in-file = ?(grep --color=always --with-filename --line-number $@quiet-grep-arg $-todo-text $path > &2)

      if $found-in-file {
        set found = $true
      }
    }

  if $found {
    if $crash-on-found {
      fail 'Critical TODOs found!'
    } else {
      console:echo 🤯 Critical TODOs found!
      put $true
    }
  } else {
    console:echo ✅ No critical TODOs found!
    put $false
  }
}
