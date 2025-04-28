use github.com/giancosta86/aurora-elvish/console

fn verify {
  console:echo 🔬 Verifying the project...
  pdm run verify
  console:echo ✅ Project verified!
}

fn build {
  console:echo 📦 Building the project...
  pdm build
  console:echo ✅ Project built successfully!
}

fn publish { |dry-run|
  if $dry-run {
    console:echo 💭 dry-run is enabled: just building the 🐍 Python project...
    pdm build
  } else {
    console:echo 📤 Publishing the 🐍 Python package...
    pdm publish
  }
}