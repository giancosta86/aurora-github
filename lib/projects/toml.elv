use re
use ../core

fn read-version { |descriptor-path|
  cat $descriptor-path | each { |line|
    var match = core:first-or-nil [(re:find '^version\s*=\s*["''](.*)["'']' $line)]

    if $match {
      put $match
      break
    }
  }
}

