use os
use github.com/giancosta86/gauntlet/v1/input
use ../python/pdm
use ../python/project

fn main {
  var pdm-version = (input:string &optional pdm-version)

  echo 🐍💻 Setting up Python context in "'"$pwd"'"...

  var descriptor = pyproject.toml

  if (not (os:is-regular $descriptor)) {
    fail 'The '$descriptor' descriptor is missing!'
  }

  pdm:ensure &version=$pdm-version

  project:install-dependencies

  echo ✅🐍 NodeJS context in "'"$pwd"'" ready!
}