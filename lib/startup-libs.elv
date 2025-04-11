use epm
use str
use ./core
use ./console

fn setup-env-vars { |inputs|
  console:inspect-trace "EPM managed directory" $epm:managed-dir

  var comma-separated-packages = (core:string-list-to-csv $inputs[packages])
  console:inspect-trace "Comma-separated packages" $comma-separated-packages

  var packages-sha = (core:to-sha $comma-separated-packages)
  console:inspect-trace "Packages SHA" $packages-sha

  var epm-cache-key = $inputs[workflow]-$inputs[run-number]-$packages-sha
  console:inspect-trace "Epm cache key" $epm-cache-key

  core:map-to-env [
    &epm-dir=$epm:managed-dir
    &comma-separated-packages=$comma-separated-packages
    &epm-cache-key=$epm-cache-key
  ]
}

fn install { |comma-separated-packages|
  str:split , $comma-separated-packages | each { |pkg|
    epm:install $pkg
  }

  console:trace 🚀Startup packages for Elvish installed!
}

fn list {
  console:print-block &emoji=📚 'Elvish startup packages' {
    epm:installed | each { |pkg|
      console:print '*' $pkg
    }
  }
}