use re
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/gauntlet/v1/input

fn main {
  var version = (input:string version)

  if (has-external wasm-pack) {
    var current-version = (wasm-pack --version)

    if (
      re:quote $version |
        put '(?:^|\s)'(all)'(?:\s|$)' |
        re:match (all) $current-version
    ) {
      echo 🎉 The requested wasm-pack version is installed!
      return
    } else {
      console:inspect &emoji=🤔 'Current wasm-pack version' $current-version
    }
  }

  echo 🌐 Installing wasm-pack $version...

  command:silence {
    npm install -g 'wasm-pack@'$version
  }

  echo ✅ wasm-pack installed!
}
