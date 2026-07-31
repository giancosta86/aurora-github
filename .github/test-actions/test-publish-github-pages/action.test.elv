use str

>> 'The website URL' {
  >> 'should be the expected one' {
    get-env website-url |
      str:trim-space (all) |
      should-be 'https://gianlucacosta.info/aurora-github/'
  }
}
