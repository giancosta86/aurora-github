fn ensure-in-branch { |branch|
  try {
    git switch -c $branch
  } catch {
    git switch $branch
  }
}