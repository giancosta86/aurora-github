use github.com/giancosta86/ethereal/v1/fs

fn run-code { |settings|
  var velvet-version = $settings[velvet-version]
  var working-directory = $settings[working-directory]
  var code = $settings[code]

  var velvet-module: = (
    use-mod 'github.com/giancosta86/velvet/'$velvet-version'/velvet'
  )

  fs:with-temp-file { |test-script-path|
    {
      printf "set pwd = ''%s''\n" $working-directory

      echo

      echo $code
    } >  $test-script-path

    velvet-module:velvet &flawless $test-script-path
  }
}