use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/highlight
use github.com/giancosta86/gauntlet/v1/input
use github.com/giancosta86/ethereal/v1/python/pipx

fn display-descriptor {
  var descriptor = pyproject.toml

  console:section &emoji=🐍 $descriptor' just before publication' {
    highlight:file $descriptor toml
  }
}

fn main {
  var pdm-version = (input:string pdm-version)
  var dry-run = (input:bool dry-run)
  var index-url = (input:string &optional index-url)

  display-descriptor

  var pdm~ = (pipx:get-command pdm &version=$pdm-version)

  if $dry-run {
    echo 💭 dry-run is enabled: just building the 🐍 Python project...

    pdm build
  } else {
    echo 📤 Publishing the 🐍 Python package...

    if $index-url {
      set-env PDM_PUBLISH_REPO $index-url
    }

    pdm publish

    echo 💫 Package published!
  }
}