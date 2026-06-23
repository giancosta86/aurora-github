use os
use ./input
use ../python/pdm

fn setup {
  var pdm-version = (input:string &optional pdm-version)

  echo 🐍💻 Setting up Python context in "'"$pwd"'"...

  if (not (os:is-regular pyproject.toml)) {
    fail 'The pyproject.toml descriptor is missing!'
  }

  pdm:ensure &version=$pdm-version

  echo ✅🐍 NodeJS context in "'"$pwd"'" ready!
}