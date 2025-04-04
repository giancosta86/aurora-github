use str
use re

fn write-env { |key value|
  echo $key'='$value >> $E:GITHUB_ENV
}

fn write-output { |key value|
  echo $key'='$value >> $E:GITHUB_OUTPUT
}

fn parse-string-list { |string-list|
  re:split ',| ' $string-list | each { |entry|
    if (not-eq $entry "") {
      put $entry
    }
  }
}

fn string-list-to-csv { |csv-list|
  parse-string-list $csv-list | str:join ,
}

fn to-sha { |source|
  echo $source |
    sha256sum |
    str:split ' ' (all) |
    take 1
}
