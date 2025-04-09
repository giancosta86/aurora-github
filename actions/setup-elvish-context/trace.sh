trace() {
  local input="$@"

  if [[ "$AURORA_GITHUB_ENABLE_TRACING" == "true" ]]
  then
    echo "$input"
  fi
}
