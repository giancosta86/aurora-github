use os
use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/map
use ../highlighting

fn parse-scope { |declared-scope|
  if (==s $declared-scope '<ROOT>') {
    console:echo 🫚 Root npm scope detected!
    put $nil
  } else {
    var actual-scope = (str:trim-prefix $declared-scope @)
    console:inspect &emoji=☂ 'Custom npm scope detected' $actual-scope
    put $actual-scope
  }
}

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
