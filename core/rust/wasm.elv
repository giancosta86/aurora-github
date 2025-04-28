use os
use github.com/giancosta86/aurora-elvish/console

fn copy-npmrc-from-project-directory {
  if (os:is-regular .npmrc) {
    console:echo 🎉 Root .npmrc configuration file found! Copying it to the package directory...
    cp .npmrc pkg/
    console:echo ✅ .npmrc file copied!
  } else {
    console:echo 💭 No .npmrc configuration file found in the project directory...
  }
}
