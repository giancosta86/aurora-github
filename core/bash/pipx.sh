installViaPipx() {
  local package="$1"
  local requestedVersion="$2"

  echo "📥Installing $package via pipx..."

  if [[ -n "$requestedVersion" ]]
  then
    echo "🔎Requested version: $requestedVersion"
  else
    echo "🔎Latest version requested"
  fi

  if [[ -n "$requestedVersion" ]]
  then
    versionArg="==$requestedVersion"
  else
    versionArg=""
  fi

  pipx install ${package}${versionArg}

  echo "✅$package installed!"
}

