use github.com/giancosta86/ethereal/v1/sdkman

fn within-temp-project { |block|
  var sdkfile-content = (slurp < $sdkman:sdkfile)

  var temp-project-dir = (get-env temp-project-dir)

  fs:clean-dir $temp-project-dir

  tmp pwd = $temp-project-dir

  print $sdkfile-content > $sdkfile

  $block
}