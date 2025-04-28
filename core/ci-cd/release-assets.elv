use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/lang
use github.com/giancosta86/aurora-elvish/seq

fn publish { |inputs|
  console:inspect-inputs $inputs

  var release-tag = $inputs[release-tag]
  var files = $inputs[files]
  var overwrite = $inputs[overwrite]

  if (seq:is-empty $files) {
    fail 'No files declared!'
  }

  var clobber-arg = (lang:ternary $overwrite [--clobber] [])

  gh release upload $@clobber-arg $release-tag $@files
}
