use os
use github.com/giancosta86/aurora-elvish/console
use ./pdm

fn -check-preconditions {
  if (not (os:is-regular pyproject.toml)) {
    fail 'The pyproject.toml descriptor is missing!'
  }
}

fn setup { |&pdm-version=$nil|
  console:echo 🐍💻 Setting up Python context in "'"$pwd"'"...

  -check-preconditions

  pdm:ensure &version=$pdm-version

  console:echo ✅🐍 NodeJS context in "'"$pwd"'" ready!
}