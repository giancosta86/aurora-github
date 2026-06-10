set -e
set -u
set -o pipefail

commandExists() {
  local command="$1"

  type "$command" > /dev/null 2>&1
}

setupElvish() {
  local version="${1:-0.21.0}"
  local architecture="${2:-linux-amd64}"

  if ! commandExists elvish
  then
    echo "📥 Installing Elvish $version for $architecture..."

    curl -so - https://dl.elv.sh/${architecture}/elvish-v${version}.tar.gz | tar -xzC /usr/local/bin

    echo "🚀 Elvish installed!"
  fi
}