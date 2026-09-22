use github.com/giancosta86/ethereal/v1/python/pipx
use github.com/giancosta86/gauntlet/v1/input
use ../python/project

fn main {
  var pdm-version = (input:string pdm-version)

  var pdm~ = (pipx:get-command pdm &version=$pdm-version)

  echo 🔬 Verifying the project...
  pdm run verify
  echo ✅ Project verified!

  echo 📦 Building the project...
  pdm build
  echo ✅ Project built!
}