use re
use github.com/giancosta86/aurora-elvish/highlighting

fn read-version { |descriptor-path|
  cat $descriptor-path | from-lines | each { |line|
    re:find '^\s*version\s*=\s*["''](.*)["'']\s*$' $line |
      each { |match|
        put $match[groups][1][text]
        return
      }
  }

  put $nil
}

fn print-content { |descriptor-path|
  cat $descriptor-path | highlighting:highlight toml
}