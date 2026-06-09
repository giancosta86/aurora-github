use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/seq

fn publish { |inputs|
  var release-tag = $inputs[release-tag]
  var files = $inputs[files]
  var overwrite = $inputs[overwrite]

  if (seq:is-empty $files) {
    fail 'No files declared!'
  }

  var clobber-arg = (lang:ternary $overwrite [--clobber] [])

  gh release upload $@clobber-arg $release-tag $@files
}
