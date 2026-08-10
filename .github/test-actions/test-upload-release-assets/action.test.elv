use os
use path
use github.com/giancosta86/gauntlet/v1/repository

var download-directory = (os:temp-dir)

fn should-match-original-in { |directory-components-within-repo|
  var filename = (one)

  var downloaded-file = (path:join $download-directory $filename)
  put $downloaded-file |
    should-be-regular

  var original-file = (repository:get-path $@directory-components-within-repo $filename)
  put $original-file |
    should-be-regular

  if (not ?(cmp -s $downloaded-file $original-file)) {
    fail $downloaded-file' is corrupted!'
  }
}

>> 'The downloaded artifacts' {
  defer {
    echo 🚮 Now deleting the download directory...
    os:remove-all $download-directory
    echo ✅ Download directory deleted!
  }

  >> 'should have the same bytes as the original files' {
    var test-tag = (get-env test-tag)

    all [
      index.html
      react.svg
      vite.svg
    ] | each { |file-name|
      gh release download $test-tag -p $file-name -D $download-directory
    }

    put index.html |
      should-match-original-in [website static]

    put react.svg |
      should-match-original-in [website nodejs src assets]

    put vite.svg |
      should-match-original-in [website nodejs src assets]
  }
}