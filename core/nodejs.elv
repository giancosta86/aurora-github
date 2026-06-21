use os
use github.com/giancosta86/ethereal/v1/command
use github.com/giancosta86/ethereal/v1/seq
use github.com/giancosta86/astral-bridge/v1/package-manager

fn try-to-run-package-script { |script|
  if (not (os:is-regular package.json)) {
    echo 💭 Cannot find package.json - will not run the "'"$script"'" script
    return
  }

  var package-json = (from-json < package.json)

  if (seq:drill-down $package-json scripts $script) {
    echo 💫 Now running the "'"$script"'" script from package.json...

    command:silence {
      package-manager:exec run $script
    }

    echo ✅ "'"$script"'" script executed!
  } else {
    echo 💭 Cannot find the "'"$script"'" script in package.json
  }
}