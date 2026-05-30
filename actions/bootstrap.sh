set -e
set -u
set -o pipefail

writeEnv() {
  local name="$1"
  local value="$2"

  echo "$name=$value" >> $GITHUB_ENV
}

commandExists() {
  local command="$1"

  type "$command" > /dev/null 2>&1
}

installElvish() {
  local version="${1:-0.21.0}"
  local architecture="${2:-linux-amd64}"

  echo "📥 Installing Elvish $version for $architecture..."

  curl -so - https://dl.elv.sh/${architecture}/elvish-v${version}.tar.gz | tar -xzvC /usr/local/bin

  echo "🚀 Elvish installed!"
}