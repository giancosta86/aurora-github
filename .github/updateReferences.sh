#!/bin/bash

branchVersion="$(git branch --show-current)"
echo "🌲Branch version: '$branchVersion'"

majorVersion="$(echo "$branchVersion" | cut -d '.' -f 1)"
echo "💎Major version: '$majorVersion'"

find ../actions \( -name "*.yml" -o -name "*.md" \) -exec sed -i -E "s/(giancosta86\/aurora-github\/actions\/[^@]+)@v[0-9]+\.[0-9]+\.[0-9]+/\1@$branchVersion/" "{}" \;

find ../actions \( -name "*.yml" -o -name "*.md" \) -exec sed -i -E "s/(giancosta86\/aurora-github\/actions\/[^@]+)@v[0-9]+/\1@$majorVersion/" "{}" \;

echo "✅Version references replaced! Now check your Git changes! 🥳"
