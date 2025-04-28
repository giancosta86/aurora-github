use os
use github.com/giancosta86/aurora-elvish/console
use ../ci-cd/env

var -sdkman-home = ~/.sdkman
var -sdkman-script = $-sdkman-home/bin/sdkman-init.sh

fn -ensure-installed {
  if (os:is-dir $-sdkman-home) {
    console:echo 🎉 It seems that SDKMAN was previously installed!
    return
  }

  console:echo 📥 Installing SDKMAN...

  curl -s 'https://get.sdkman.io' | bash

  console:echo ✅ SDKMAN installed!
}

fn install-sdk { |candidate version|
  -ensure-installed

  console:echo 📥 Installing $candidate'('$version')...'

  bash -c "source '"$-sdkman-script"'; sdk install '"$candidate"' '"$version"'"

  var sdk-bin = $-sdkman-home/candidates/$candidate/$version/bin

  if (not (os:is-dir $sdk-bin)) {
    fail 'Inexistent sdk ''bin'' directory: '$sdk-bin
  }

  var updated-path = $sdk-bin':'(get-env PATH)

  set-env PATH $updated-path
  env:write PATH $updated-path

  console:echo ✅ $candidate'('$version')' installed!
}
