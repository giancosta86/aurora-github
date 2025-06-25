use ./my-ops

describe 'Summing three numbers' {
  describe 'when they are all 0' {
    it 'should return 0' {
      my-ops:test-sum 0 0 0 |
        should-be 0
    }
  }

  describe 'when they are not 0' {
    it 'should return the expected sum' {
      my-ops:test-sum 90 5 3 |
        should-be 98
    }
  }
}