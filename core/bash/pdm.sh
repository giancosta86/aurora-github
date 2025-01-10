ensurePdm() {
  local requestedVersion="$1"

  installPdm() {
    source "$GITHUB_ACTION_PATH/../../core/bash/pipx.sh"

    installViaPipx pdm "$requestedVersion"
  }

  if which pdm
  then
    echo "🌟pdm is already installed!"

    if [[ -n "$requestedVersion" ]]
    then
      local installedVersion="$(pdm --version)"

      echo "🔎Installed pdm version: '$installedVersion'"

      if echo "$installedVersion" | grep -Pq "\b$requestedVersion\b"
      then
        echo "✅The requested pdm version is already installed!"
      else
        installPdm
      fi
    fi
  else
    installPdm
  fi
}