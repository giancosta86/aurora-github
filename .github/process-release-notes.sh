notesFile="$1"

for actionFolder in actions/*
do
  action="$(basename "$actionFolder")"

  sed -i "s/\`$action\`/[$action](actions\/$action\/README.md)/" "$notesFile"
done