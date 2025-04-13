sdkmanHome="$HOME/.sdkman"

validateInputs() {
  local candidate="$1"
  local version="$2"

  if [[ -z "$candidate" ]]
  then
    echo "❌Missing action input: 'candidate'!" >&2
    exit 1
  fi

  if [[ -z "$version" ]]
  then
    echo "❌Missing action input: 'version'!" >&2
    exit 1
  fi
}

ensureSdkmanInstalled() {
  if [[ -d "$sdkmanHome" ]]
  then
    echo "☑It seems that SDKMAN was previously installed"
    return 0
  fi

  echo "📥Installing SDKMAN..."

  curl -s "https://get.sdkman.io" | bash

  echo "✅SDKMAN installed!"
}

ensureSdkmanReady() {
  if ! type -t sdk >/dev/null 2>&1
  then
    ensureSdkmanInstalled

    echo '🚀Setting up SDKMAN...'

    source "$sdkmanHome/bin/sdkman-init.sh"
  fi

  echo "✅SDKMAN ready!"
}

installRequestedSdk() {
  local candidate="$1"
  local version="$2"

  echo "📥Installing $candidate($version)..."

  sdk install "$candidate" "$version"

  echo "PATH=$sdkmanHome/candidates/candidate/$version:$PATH" >> $GITHUB_ENV

  echo "✅$candidate($version) installed!"
}

installViaSdkman() {
  local candidate="$1"
  local version="$2"

  validateInputs "$candidate" "$version"

  ensureSdkmanReady

  installRequestedSdk "$candidate" "$version"
}