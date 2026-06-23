fn verify {
  echo 🔬 Verifying the project...
  pdm run verify
  echo ✅ Project verified!
}

fn build {
  echo 📦 Building the project...
  pdm build
  echo ✅ Project built successfully!
}

fn publish { |dry-run|
  if $dry-run {
    echo 💭 dry-run is enabled: just building the 🐍 Python project...
    build
  } else {
    echo 📤 Publishing the 🐍 Python package...
    pdm publish
    echo 💫 Package published!
  }
}