use str
use github.com/giancosta86/ethereal/v1/fs

fn run-code { |settings|
  var velvet-version = $settings[velvet-version]

  var working-directory = (get-env working-directory)
  var code = (get-env velvet-code)

  var velvet-module: = (
    use-mod 'github.com/giancosta86/velvet/'$velvet-version'/velvet'
  )

  fs:with-temp-file { |test-script-path|
    {
      str:replace "'" "''" $working-directory |
        echo "cd '"(all)"'"

      echo

      echo $code
    } > $test-script-path

    velvet-module:velvet &flawless $test-script-path
  }
}