use os
use ./pdm

fn setup { |&pdm-version=$nil|
  echo 🐍💻 Setting up Python context in "'"$pwd"'"...

  if (not (os:is-regular pyproject.toml)) {
    fail 'The pyproject.toml descriptor is missing!'
  }

  pdm:ensure &version=$pdm-version

  echo ✅🐍 NodeJS context in "'"$pwd"'" ready!
}