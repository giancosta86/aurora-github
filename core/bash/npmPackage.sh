tryToRunNpmBuildScript() {
  if jq -e '.scripts.build? != null' package.json > /dev/null
  then
    echo "✅'build' script found in package.json - now running it!"
    pnpm build
  else
    echo "💭No 'build' script found in package.json - skipping the build step."
  fi
}