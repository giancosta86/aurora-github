use ../python/project
use ./input

fn main {
  var dry-run = (input:bool dry-run)

  if $dry-run {
    echo 💭 dry-run is enabled: just building the 🐍 Python project...

    project:build
  } else {
    echo 📤 Publishing the 🐍 Python package...

    pdm publish

    echo 💫 Package published!
  }
}