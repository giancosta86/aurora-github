use github.com/giancosta86/astral-bridge/v1/package-manager

fn run-verify {
  echo 📦 Now running the '''verify''' script from package.json...

  package-manager:exec run verify

  echo ✅Verification script in package.json OK!
}

fn run-build {
  echo 📦 Now running the '''build''' script from package.json...

  package-manager:exec run build

  echo ✅Build script in package.json OK!
}

fn main {
  run-verify

  run-build
}