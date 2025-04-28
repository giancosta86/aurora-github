var -publication-preparers = [
  &mvn={
    use ./maven/settings
    settings:prepare-for-publication
  }

  &gradle={
    use ./gradle/settings
    settings:prepare-for-publication
  }
]

fn prepare-for-publication { |build-tool|
  var preparer = $-publication-preparers[$build-tool]

  $preparer
}