use str

var branch-version = ""

try {
  set branch-version = (git branch --show-current)
} catch {
  #Just do nothing
}

if (==s $branch-version main) {
  echo "💡Skipping action reference update when on main!"
  exit 0
}

if (==s $branch-version "") {
  echo "💡Skipping action reference update when not in a checkout/switch!"
  exit 0
}

echo 🌲Branch version: "'"$branch-version"'"


var major-version = (str:split . $branch-version | take 1)
echo 💎Major version: "'"$major-version"'"

put actions/**[nomatch-ok].{yml md} | peach { |file-path|
  sed -i -E 's/(giancosta86\/aurora-github\/actions\/[^@]+)@v[0-9]+\.[0-9]+\.[0-9]+/\1@'$branch-version'/' $file-path
  sed -i -E 's/(giancosta86\/aurora-github\/actions\/[^@]+)@v[0-9]+/\1@'$major-version'/' $file-path
}

if (not ?(git diff --quiet)) {
  echo 🧭Creating a commit to track the updated action references...
  git add .
  git commit -m "Update action references"
  echo ✅Commit created!
} else {
  echo ✅The action references are already set up!
}