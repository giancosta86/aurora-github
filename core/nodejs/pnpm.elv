use os
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/map
use ../highlighting


fn run-optional-script { |script|
  var package-json = (from-json < package.json)

  var scripts = (coalesce (map:get-value $package-json scripts) [&])

  if (has-key $scripts $script) {
    console:echo 🛠 Optional "'"$script"'" script found in package.json - now running it!

    pnpm $script
  } else {
    console:echo 💭 Optional "'"$script"'" script not found in package.json...
  }
}
