use github.com/giancosta86/gauntlet/v1/repository

cd (repository:get-path tests elvish)

>> 'The verification script output' {
  >> 'should exist' {
    put verify-out.txt |
      should-be-regular
  }
}

>> 'The Velvet test scripts output' {
  >> 'should not exist' {
    put velvet*[nomatch-ok].txt |
      should-emit []
  }
}
