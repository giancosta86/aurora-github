use path

cd (path:join .. .. .. tests elvish)

>> 'The verification script output' {
  >> 'should exist' {
    put script-out.txt |
      should-be-regular
  }
}

>> 'The Velvet test script output' {
  >> 'should not exist' {
    put velvet*[nomatch-ok].txt |
      should-emit []
  }
}
