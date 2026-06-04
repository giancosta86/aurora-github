describe 'Among numeric operations' {
  describe 'addition' {
    it 'should work' {
      + 90 2 |
        should-be 92
    }
  }

  describe 'division' {
    it 'should work' {
      / 90 3 |
        should-be 30
    }
  }
}