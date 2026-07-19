use os
use github.com/giancosta86/ethereal/v1/command

var -sdkman-home = ~/.sdkman
var -sdkman-script = $-sdkman-home/bin/sdkman-init.sh

fn -ensure-installed {
  if (os:is-dir $-sdkman-home) {
    echo 🎉 It seems that SDKMAN was previously installed!
    return
  }

  echo 📥 Installing SDKMAN...

  command:silence {
    curl -s 'https://get.sdkman.io' | bash
  }

  echo ✅ SDKMAN installed!
}

fn install-sdk { |candidate version|
  -ensure-installed

  echo 📥 Installing $candidate'('$version')...'

  command:silence {
    bash -c "source '"$-sdkman-script"'; sdk install '"$candidate"' '"$version"'"
  }

  echo ✅ $candidate'('$version')' installed!

  var sdk-bin = $-sdkman-home/candidates/$candidate/$version/bin

  if (not (os:is-dir $sdk-bin)) {
    echo 💭 Inexistent sdk bin directory...
  } else {
    var updated-path = $sdk-bin':'(get-env PATH)

    set-env PATH $updated-path

    echo ✅ SDK bin directory prepended to the PATH!
  }
}
