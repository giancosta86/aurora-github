use os

echo 🎭 (get-env header)

os:remove-all verify.elv

put *[nomatch-ok].txt |
  each $os:remove-all~

os:remove-all metadata.json

if (eq (get-env include-metadata) true) {
  cp metadata.potential.json metadata.json
}