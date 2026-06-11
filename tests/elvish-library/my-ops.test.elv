use ./my-ops

# TODO! This is another test
>> 'Summing three numbers' {
  >> 'when they are all 0' {
    >> 'should return 0' {
      my-ops:test-sum 0 0 0 |
        should-be 0
    }
  }

  >> 'when they are not 0' {
    >> 'should return the expected sum' {
      my-ops:test-sum 90 5 3 |
        should-be 98
    }
  }
}