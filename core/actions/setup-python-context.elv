use os
use github.com/giancosta86/ethereal/v1/python/pipx
use github.com/giancosta86/gauntlet/v1/input

fn check-directory-structure {
  var project-file = pyproject.toml

  if (not (os:is-regular $project-file)) {
    fail 'The '$project-file' project descriptor is missing!'
  }
}

fn main {
  var pdm-version = (input:string pdm-version)

  var install-dependencies = (input:bool install-dependencies)

  echo 🐍💻 Setting up Python context in "'"$pwd"'"...

  check-directory-structure

  var pdm~ = (pipx:get-command pdm &version=$pdm-version)

  if $install-dependencies {
    echo 📥 Installing project dependencies...

    pdm install

    echo 🚀 Project dependencies ready!
  } else {
    echo 💭 Skipping installation of the project dependencies...
  }

  echo ✅🐍 Python context in "'"$pwd"'" ready!
}