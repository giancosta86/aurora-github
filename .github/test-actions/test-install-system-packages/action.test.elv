>> 'The expected command' {
  >> 'should now be available' {
    get-env expected-command |
      command:exists-in-bash |
      should-be $true
  }
}