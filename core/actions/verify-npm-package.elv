use github.com/giancosta86/astral-bridge/v2/nodejs/package-manager

fn run-package-scripts {
  echo 💫 Now trying to run the verify script from package.json...
  package-manager:run-script &optional verify

  echo 💫 Now trying to run the build script from package.json...
  package-manager:run-script &optional build
}