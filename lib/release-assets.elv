use ./console
use ./lang

fn publish { |inputs|
  console:inspect-inputs $inputs

  var release-tag = $inputs[release-tag]
  var files = $inputs[files]
  var overwrite = $inputs[overwrite]

  var clobber-arg = (lang:ternary $overwrite [--clobber] [])

  gh release upload $@clobber-arg $release-tag $@files
}


