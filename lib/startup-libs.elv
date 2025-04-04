use epm
use str
use ./core

fn setup-env-vars { |inputs|
  echo 🔎EPM managed directory: "'"$epm:managed-dir"'"

  var comma-separated-packages = (core:string-list-to-csv $inputs[packages])
  echo 🔎Comma-separated packages: "'"$comma-separated-packages"'"

  var packages-sha = (core:to-sha $comma-separated-packages)
  echo 🔎Packages SHA: $packages-sha

  var epm-cache-key = $inputs[workflow]-$inputs[run-number]-$packages-sha
  echo 🔎Epm cache key: "'"$epm-cache-key"'"

  core:write-env epm-dir $epm:managed-dir
  core:write-env comma-separated-packages $comma-separated-packages
  core:write-env epm-cache-key $epm-cache-key
}

fn install { |comma-separated-packages|
  str:split , $comma-separated-packages | each { |pkg|
    epm:install $pkg
  }

  echo 🚀Startup packages for Elvish installed!
}

fn list {
  echo 📚Elvish startup packages:
  epm:installed | each { |pkg|
    echo '*' $pkg
  }
  echo 📚📚📚
}