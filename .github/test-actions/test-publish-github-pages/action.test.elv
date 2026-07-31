use str

>> 'The website URL' {
  >> 'should be the expected one' {
    var website-url = (get-env website-url)

    echo 🌐 WEBSITE URL: "'"$website-url"'"

    put $website-url |
      should-be 'https://gianlucacosta.info/aurora-github/'
  }
}
