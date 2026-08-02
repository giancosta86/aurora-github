use github.com/giancosta86/gauntlet/v1/repository

cd (repository:get-path tests npm-package)

>> 'The branch version' {
  >> 'should be injected into package.json' {
    from-json < package.json |
      put (all)[version] |
      should-be (get-env version)
  }
}