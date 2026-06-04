use ../branch-version
use ../ci-cd/output

fn main {
  var result = (branch-version:detect)

  echo 🌲 Current Git branch: $result[branch]

  echo 🦋 Detected version: $result[version]

  echo 🧵 Escaped version: $result[escaped-version]

  echo 🪩 Major version: $result[major]

  put $result |
    output:map
}