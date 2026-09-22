use os
use github.com/giancosta86/ethereal/v1/python/pipx
use github.com/giancosta86/gauntlet/v1/input

var python-project-file = pyproject.toml

fn check-directory-structure {
  if (not (os:is-regular $python-project-file)) {
    fail 'The '$python-project-file' project descriptor is missing!'
  }
}

fn install-dependencies { |pdm-version|
  var pdm~ = (pipx:get-command pdm &version=$pdm-version)

  echo 📥 Installing project dependencies...

  pdm install

  echo 🚀 Project dependencies ready!
}

fn main {
  var pdm-version = (input:string pdm-version)

  var install-dependencies = (input:bool install-dependencies)

  echo 🐍💻 Setting up Python context in "'"$pwd"'"...

  check-directory-structure

  if $install-dependencies {
    install-dependencies $pdm-version
  } else {
    echo 💭 Skipping installation of the project dependencies...
  }

  echo ✅🐍 Python context in "'"$pwd"'" ready!
}