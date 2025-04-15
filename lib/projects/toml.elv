use re
use ../core

fn read-version { |descriptor-path|
  cat $descriptor-path | each { |line|
    var match = (core:first-or-default [(re:find '^version\s*=\s*["''](.*)["'']' $line)])

    if $match {
      put $match[groups][1][text]
      return
    }
  }
}

