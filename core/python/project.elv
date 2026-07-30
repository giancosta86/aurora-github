fn install-dependencies {
  echo 📥 Installing project dependencies...
  pdm install
  echo 🚀 Project dependencies ready!
}

fn verify {
  echo 🔬 Verifying the project...
  pdm run verify
  echo ✅ Project verified!
}

fn build {
  echo 📦 Building the project...
  pdm build
  echo ✅ Project built!
}
