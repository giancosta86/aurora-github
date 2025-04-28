use re
use ../seq

fn read-version { |descriptor-path|
  cat $descriptor-path | each { |line|
    var match = (seq:first-or-default [(re:find '^version\s*=\s*["''](.*)["'']' $line)])

    if $match {
      put $match[groups][1][text]
      return
    }
  }
}

