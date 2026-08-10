>> 'The expected command' {
  >> 'should not pre-exist' {
    get-env expected-command |
      command:exists-in-bash |
      should-be $false
  }
}