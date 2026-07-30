use github.com/giancosta86/gauntlet/v1/input
use ../python/project

fn display-descriptor {
  var descriptor = pyproject.toml

  console:section &emoji=🐍 $descriptor' just before publication' {
    highlight:file $descriptor toml
  }
}

fn main {
  var dry-run = (input:bool dry-run)

  display-descriptor

  if $dry-run {
    echo 💭 dry-run is enabled: just building the 🐍 Python project...

    project:build
  } else {
    echo 📤 Publishing the 🐍 Python package...

    pdm publish

    echo 💫 Package published!
  }
}