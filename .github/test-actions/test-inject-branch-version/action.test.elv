use path

cd (path:join .. .. .. tests npm-package)

>> 'The branch version' {
  >> 'should be injected into package.json' {
    from-json < package.json |
      put (all)[version] |
      should-be (get-env version)
  }
}