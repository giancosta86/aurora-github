use os
use str
use ../console
use ../map

fn parse-scope { |declared-scope|
  if (==s $declared-scope '<ROOT>') {
    console:echo 🫚Root npm scope detected!
    put $nil
  } else {
    var actual-scope = (str:trim-prefix $declared-scope @)
    console:inspect &emoji=🖌 'Custom npm scope detected' $actual-scope
    put $actual-scope
  }
}

fn run-optional-script { |script|
  var package-json = (from-json < package.json)

  var scripts = (coalesce (map:get-value $package-json scripts) [&])

  if (has-key $scripts $script) {
    echo 🛠Optional "'"$script"'" script found in package.json - now running it!

    pnpm $script
  } else {
    echo 💭Optional "'"$script"'" script not found in package.json...
  }
}

fn ensure-config {
  var config-path = .npmrc

  if (not (os:is-regular $config-path)) {
    echo 🌟It seems you do not have a $config-path file - generating a default one...

    echo '//registry.npmjs.org/:_authToken=${NPM_TOKEN}' > $config-path

    console:section &emoji=🎀 'Your auto-generated '$config-path' configuration file' {
      cat $config-path
    }
  } else {
    echo 🌟You already have a custom $config-path file - ready to publish!
  }
}