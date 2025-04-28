use epm
use str

var -required-packages = [
  github.com/giancosta86/aurora-elvish
]

var -aurora-elvish-version = 'v1'

fn -tracer-action { |block|
  if (has-env AURORA_GITHUB_TRACING_ENABLED) {
    $block > &2
  }
}

fn trace-echo { |@values|
  -tracer-action {
    echo $@values
  }
}

fn trace-inspect { |&emoji=🔎 description value|
  -tracer-action {
    print $emoji $description': '
    pprint $value
  }
}

fn -get-sha { |value|
  to-string $value |
    sha256sum |
    str:split ' ' (all) |
    take 1
}

fn -to-csv { |items|
  str:join , $items
}

fn -split-csv { |source|
  str:split , $source |
    each $str:trim-space~ |
    keep-if { |value| !=s $value '' }
}

fn confirm-aurora-github {
  trace-echo 🔮 Now booting aurora-github for Elvish!
}

fn set-epm-vars { |inputs|
  trace-inspect &emoji=📥 Inputs $inputs

  var workflow = $inputs[workflow]
  var run-number = $inputs[run-number]
  var packages = [(-split-csv $inputs[packages])]

  var actual-packages = [$@-required-packages $@packages]

  var csv-packages = (-to-csv $actual-packages)
  trace-inspect 'Comma-separated packages' $csv-packages

  var packages-sha = (-get-sha $csv-packages)
  trace-inspect 'Packages SHA' $packages-sha

  var epm-cache-key = $workflow'-'$run-number'-'$packages-sha
  trace-inspect 'EPM cache key' $epm-cache-key

  trace-inspect 'EPM managed directory' $epm:managed-dir

  {
    echo csv-packages=$csv-packages
    echo epm-cache-key=$epm-cache-key
    echo epm-managed-dir=$epm:managed-dir
  } >> (get-env GITHUB_ENV)
}

fn -checkout-aurora-elvish-version {
  tmp pwd = $epm:managed-dir/github.com/giancosta86/aurora-elvish

  git checkout -q $-aurora-elvish-version

  use github.com/giancosta86/aurora-elvish/console

  -tracer-action {
    console:echo 🔮 aurora-elvish ready!
  }
}

fn install-packages { |csv-packages|
  var packages = [(-split-csv $csv-packages)]

  trace-echo 📚 Packages to install: $packages

  for package $packages {
    epm:install $package
  }

  -checkout-aurora-elvish-version

  trace-echo 🚀 Startup packages for Elvish installed!
}

fn list-packages {
  trace-echo 📚 Elvish startup packages

  epm:installed | each { |pkg|
    trace-echo '*' $pkg
  }

  trace-echo 📚📚📚
}