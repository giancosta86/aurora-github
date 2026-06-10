use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/string
use ../velvet
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

  fs:with-temp-file { |test-script-path|
    {
      put $working-directory |
        string:escape-single-quotes |
        echo "cd '"(all)"'"

      echo

      echo $code
    } > $test-script-path

    velvet:run-flawless $velvet-version $test-script-path
  }
}