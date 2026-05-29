set -e
set -u
set -o pipefail

tracingVarName='AURORA_GITHUB_TRACING_ENABLED'

requireInput() {
  local name="$1"
  local value="$2"

  if [[ -z "$value" ]]
  then
    echo "❌ Missing action input: '$name'!" >&2
    exit 1
  fi
}

writeEnv() {
  local name="$1"
  local value="$2"

  echo "$name=$value" >> $GITHUB_ENV
}

not() {
  local value="$1"

  if [[ "$value" == 'true' ]]
  then
    echo false
  else
    echo true
  fi
}

setTracing() {
  local enabled="$1"

  export "$tracingVarName=$enabled"

  writeEnv $tracingVarName "$enabled"
}

trace() {
  if [[ "${!tracingVarName:-}" == "true" ]]
  then
    echo "$@"
  fi
}

shouldInstallCommand() {
  local command="$1"
  local skipIfExisting="$2"

  if type "$command" > /dev/null 2>&1
  then
    trace "🌟The '$command' command is already installed on the system!"

    if [[ "$skipIfExisting" == "true" ]]
    then
      trace "💫Skipping the setup, as requested!"
      return 1
    else
      trace "📥Still proceeding with the setup, as requested!"
      return 0
    fi
  fi

  trace "💭 The '$command' command is not available - now installing it..."
  return 0
}

installElvish() {
  local version="${1:-0.21.0}"
  local architecture="${2:-linux-amd64}"

  echo "📥 Installing Elvish $version for $architecture..."

  curl -so - https://dl.elv.sh/${architecture}/elvish-v${version}.tar.gz | tar -xzvC /usr/local/bin

  echo "🚀 Elvish installed!"
}