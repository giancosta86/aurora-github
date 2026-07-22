use os
use path

var download-directory = (os:temp-dir)

fn should-match-original-in { |source-directory-components|
  var filename = (one)

  var downloaded-file = (path:join $download-directory $filename)

  var original-file = (path:join $@source-directory-components $filename)

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
    var tag = (get-env tag)

    all [
      index.html
      react.svg
      vite.svg
    ] | each { |file-name|
      gh release download $tag -p $file-name -D $download-directory
    }

    put index.html |
      should-match-original-in [website static]

    put react.svg |
      should-match-original-in [website nodejs src assets]

    put vite.svg |
      should-match-original-in [website nodejs src assets]
  }
}