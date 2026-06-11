use os
use github.com/giancosta86/ethereal/v1/command
use ../ci-cd/env
use ../std-err

var -sdkman-home = ~/.sdkman
var -sdkman-script = $-sdkman-home/bin/sdkman-init.sh

fn -ensure-installed {
  if (os:is-dir $-sdkman-home) {
    std-err:echo 🎉 It seems that SDKMAN was previously installed!
    return
  }

  std-err:echo 📥 Installing SDKMAN...

  command:silence {
    curl -s 'https://get.sdkman.io' | bash
  }

  std-err:echo ✅ SDKMAN installed!
}

fn install-sdk { |candidate version|
  -ensure-installed

  std-err:echo 📥 Installing $candidate'('$version')...'

  command:silence {
    bash -c "source '"$-sdkman-script"'; sdk install '"$candidate"' '"$version"'"
  }

  var sdk-bin = $-sdkman-home/candidates/$candidate/$version/bin

  if (not (os:is-dir $sdk-bin)) {
    fail 'Inexistent sdk ''bin'' directory: '$sdk-bin
  }

  var updated-path = $sdk-bin':'(get-env PATH)

  env:write PATH $updated-path

  std-err:echo ✅ $candidate'('$version')' installed!
}
