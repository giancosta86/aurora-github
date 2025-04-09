use str
use ./console
use ./core

fn publish { |inputs|
  console:inspect-inputs $inputs

  var release-tag = $inputs[release-tag]
  var files = $inputs[files]
  var overwrite = (core:parse-bool $inputs[overwrite])

  var clobber-arg = (core:ternary $overwrite '--clobber' '')

  gh release upload $clobber-arg $release-tag {(str:split ' ' $files)}
}


