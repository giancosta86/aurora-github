use epm
use str
use ./console
use ./env
use ./seq
use ./sha
use ./trace

fn setup-env-vars { |inputs|
  console:inspect-inputs $inputs

  var workflow = $inputs[workflow]
  var run-number = $inputs[run-number]
  var packages = $inputs[packages]

  var csv-packages = (seq:to-csv $packages)
  trace:inspect 'Comma-separated packages' $csv-packages

  var packages-sha = (sha:compute256 $csv-packages)
  trace:inspect 'Packages SHA' $packages-sha

  var epm-cache-key = $workflow'-'$run-number'-'$packages-sha
  trace:inspect 'EPM cache key' $epm-cache-key

  trace:inspect 'EPM managed directory' $epm:managed-dir

  env:map [
    &csv-packages=$csv-packages
    &epm-cache-key=$epm-cache-key
    &epm-managed-dir=$epm:managed-dir
  ]
}

fn install { |packages|
  console:inspect &emoji=📚 'Packages to install' $packages

  for package $packages {
    epm:install $package
  }

  echo 🚀Startup packages for Elvish installed!
}

fn list {
  console:section &emoji=📚 'Elvish startup packages' {
    epm:installed | each { |pkg|
      echo '*' $pkg
    }
  }
}