use github.com/giancosta86/ethereal/v1/curl
use ../jvm/sdkman
use ./input

fn main {
  var candidate = (input:string candidate)

  var version = (input:string version)

  echo 📢 Configuring curl so that it outputs errors only...
  curl:display-errors-only

  sdkman:install-sdk $candidate $version
}