use path
use str
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/string
use ./input

fn main {
  var working-directory = (
    input:directory working-directory
  )
  var velvet-version = (
    input:string velvet-version
  )
  var code = (
    input:string code
  )

  var velvet-module: = (
    use-mod 'github.com/giancosta86/velvet/'$velvet-version'/velvet'
  )

  fs:with-temp-file { |test-script-path|
    {
      put $working-directory |
        string:escape-single-quotes |
        echo "cd '"(all)"'"

      echo

      echo $code
    } > $test-script-path

    velvet-module:velvet &flawless $test-script-path
  }
}