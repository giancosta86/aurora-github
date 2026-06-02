use path
use str
use github.com/giancosta86/ethereal/v1/fs
use ./ci-cd/env

fn run-code {
  var working-directory = (
    env:directory working-directory
  )
  var velvet-version = (
    env:get-value velvet-version
  )
  var code = (
    env:escape-single-quotes code
  )

  var velvet-module: = (
    use-mod 'github.com/giancosta86/velvet/'$velvet-version'/velvet'
  )

  fs:with-temp-file { |test-script-path|
    {
      echo "cd '"$working-directory"'"

      echo

      echo $code
    } > $test-script-path

    echo 🐞
    echo $code
    echo 🐞🐞🐞

    velvet-module:velvet &flawless $test-script-path
  }
}